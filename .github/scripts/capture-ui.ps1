param([Parameter(Mandatory = $true)][string]$ExeDirectory, [string]$Locales = 'en-US,zh-CN,ja-JP,ko-KR')

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName UIAutomationTypes
Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class UiCapture {
    [StructLayout(LayoutKind.Sequential)]
    public struct RECT { public int Left, Top, Right, Bottom; }
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd, out RECT rect);
    [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr hWnd, IntPtr hdc, uint flags);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll", CharSet = CharSet.Unicode)]
    public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint msg, UIntPtr wParam, string lParam, uint flags, uint timeout, out UIntPtr result);
}
'@

$accessibilityKey = 'HKCU:\Software\Microsoft\Accessibility'
New-Item -Path $accessibilityKey -Force | Out-Null
New-ItemProperty -Path $accessibilityKey -Name TextScaleFactor -Value 150 -PropertyType DWord -Force | Out-Null
$messageResult = [UIntPtr]::Zero
[UiCapture]::SendMessageTimeout([IntPtr]0xffff, 0x1a, [UIntPtr]::Zero, 'Accessibility', 2, 1000, [ref]$messageResult) | Out-Null
Start-Sleep -Seconds 2
try {
    [Windows.UI.ViewManagement.UISettings, Windows.UI.ViewManagement, ContentType = WindowsRuntime] | Out-Null
    $uiSettings = New-Object Windows.UI.ViewManagement.UISettings
    Write-Host "Requested text scale: 150%; reported scale: $($uiSettings.TextScaleFactor)"
}
catch { Write-Warning "Unable to read UISettings text scale: $_" }

$outputDir = Join-Path $env:GITHUB_WORKSPACE 'ui-evidence'
New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
$settingsDir = Join-Path $env:LOCALAPPDATA 'SLauncher\UserCache'
New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null
$exePath = Join-Path $ExeDirectory 'SLauncher.exe'
if (-not (Test-Path -LiteralPath $exePath)) { throw "Missing executable: $exePath" }

function Save-Window([IntPtr]$handle, [string]$path) {
    $rect = New-Object UiCapture+RECT
    if (-not [UiCapture]::GetWindowRect($handle, [ref]$rect)) { throw 'GetWindowRect failed' }
    $width = $rect.Right - $rect.Left
    $height = $rect.Bottom - $rect.Top
    if ($width -le 0 -or $height -le 0) { throw 'Window has no visible area' }
    $bitmap = New-Object System.Drawing.Bitmap($width, $height)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    try {
        $hdc = $graphics.GetHdc()
        try { $ok = [UiCapture]::PrintWindow($handle, $hdc, 2) }
        finally { $graphics.ReleaseHdc($hdc) }
        if (-not $ok) { throw 'PrintWindow failed' }
        $bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $graphics.Dispose()
        $bitmap.Dispose()
    }
}

$titles = @{ 'en-US' = 'Settings'; 'zh-CN' = '设置'; 'ja-JP' = '設定'; 'ko-KR' = '설정' }
foreach ($locale in ($Locales -split ',')) {
    $settings = @{ language = $locale; startWithWindows = $false; minimizeToTray = $false }
    $settings | ConvertTo-Json | Set-Content -Encoding UTF8 (Join-Path $settingsDir 'userSettings.json')
    $proc = Start-Process -FilePath $exePath -WorkingDirectory $ExeDirectory -PassThru
    try {
        $handle = [IntPtr]::Zero
        for ($i = 0; $i -lt 30; $i++) {
            Start-Sleep -Seconds 1
            $proc.Refresh()
            if ($proc.HasExited) { throw "$locale exited with code $($proc.ExitCode)" }
            if ($proc.MainWindowHandle -ne [IntPtr]::Zero) { $handle = $proc.MainWindowHandle; break }
        }
        if ($handle -eq [IntPtr]::Zero) { throw "$locale main window was not available" }
        Start-Sleep -Seconds 3
        [UiCapture]::SetForegroundWindow($handle) | Out-Null
        $main = [System.Windows.Automation.AutomationElement]::FromHandle($handle)
        foreach ($id in @('AddFileBtn', 'AddFolderBtn', 'AddWebsiteBtn')) {
            $condition = New-Object System.Windows.Automation.PropertyCondition(
                [System.Windows.Automation.AutomationElement]::AutomationIdProperty, $id)
            $button = $main.FindFirst([System.Windows.Automation.TreeScope]::Descendants, $condition)
            if ($null -eq $button) { throw "$locale could not find $id" }
            Write-Host "$locale $id | $($button.Current.Name) | $($button.Current.BoundingRectangle)"
        }
        Save-Window $handle (Join-Path $outputDir "main-$locale.png")

        $settingsCondition = New-Object System.Windows.Automation.PropertyCondition(
            [System.Windows.Automation.AutomationElement]::AutomationIdProperty, 'SettingsButton')
        $settingsButton = $main.FindFirst([System.Windows.Automation.TreeScope]::Descendants, $settingsCondition)
        if ($null -eq $settingsButton) { throw "$locale could not find SettingsButton" }
        $settingsButton.GetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern).Invoke()
        Start-Sleep -Seconds 3
        $pidCondition = New-Object System.Windows.Automation.PropertyCondition(
            [System.Windows.Automation.AutomationElement]::ProcessIdProperty, $proc.Id)
        $windows = [System.Windows.Automation.AutomationElement]::RootElement.FindAll(
            [System.Windows.Automation.TreeScope]::Children, $pidCondition)
        $settingsWindow = $null
        foreach ($window in $windows) {
            if ($window.Current.Name -eq $titles[$locale]) { $settingsWindow = $window; break }
        }
        if ($null -eq $settingsWindow) { throw "$locale settings window was not available" }
        $elements = $settingsWindow.FindAll(
            [System.Windows.Automation.TreeScope]::Descendants,
            [System.Windows.Automation.Condition]::TrueCondition)
        foreach ($element in $elements) {
            $pattern = $null
            if ($element.TryGetCurrentPattern([System.Windows.Automation.ScrollPattern]::Pattern, [ref]$pattern)) {
                if ($pattern.Current.VerticallyScrollable) {
                    $pattern.SetScrollPercent([System.Windows.Automation.ScrollPattern]::NoScroll, 100)
                    break
                }
            }
        }
        Start-Sleep -Seconds 2
        $settingsHandle = [IntPtr]$settingsWindow.Current.NativeWindowHandle
        if ($settingsHandle -ne [IntPtr]::Zero) {
            [UiCapture]::SetForegroundWindow($settingsHandle) | Out-Null
            Save-Window $settingsHandle (Join-Path $outputDir "settings-$locale.png")
        }
    }
    finally {
        if (-not $proc.HasExited) { Stop-Process -Id $proc.Id -Force }
    }
}
