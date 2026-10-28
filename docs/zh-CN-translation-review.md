# SLauncher 简体中文资源审校记录

- 逐条对照范围：上游原有英文资源的 133 个唯一键；后续新增的 43 个键不在下方对照表中。目前英文和简体中文资源各有 176 个唯一键。
- 上游和个人副本基准：`3a4f79e822fa051e1faa0cda6abb98b574ecc25a`。
- 审校依据：[英文资源](../SLauncher/Strings/en-US/Resources.resw)、[日文资源](../SLauncher/Strings/ja-JP/Resources.resw)、[韩文资源](../SLauncher/Strings/ko-KR/Resources.resw)及相关界面与代码。中文列为建议译文，尚待用户审阅和 Windows 实机核验。
- 当前工作分支已接入简体中文语言选项和资源，并补充此前遗漏的界面文字；日文和韩文缺少的新增资源使用英文回退。译文仍是草稿，尚未编译或在 Windows 上验证。

## 需要讨论和验证

| 项目 | 证据与建议 |
| --- | --- |
| `DefaultTabName` | 英文 `Main` 是默认标签名称。初稿的“主页”可能让人联想到网页，建议用“主”；也可选“主标签页”。已有用户名称不应在语言切换时被覆盖。 |
| `NewTabName` | `New Tab {0}` 是新标签的名称，而非创建按钮；建议“新标签页 {0}”。 |
| `SettingsLanguageDescription` | 英文资源称需要重启；日文、韩文各有两个同名键，后一个不含此句并覆盖前一个。设置窗口的语言切换代码会立即调用 `ChangeLanguage`。当前中文暂保留英文的重启提示，待实机核验后再讨论统一文案。 |
| `SettingsRestartRequired` | 资源同样称语言更改需要重启；静态检索未发现直接引用，不能排除动态使用。暂保留原意，待代码和实机复核。 |
| `EditItem_LinkTooltip` | 原文称实际路径或 URL 通常与显示文本相同；代码允许显示文本与路径分开，常见文件也可能显示文件名。中文暂忠于原文，建议后续核验后考虑删除这句。 |
| `EditItem_SaveButton` | 英文是 `Save and Exit`，但按钮处理代码保存项目后只关闭编辑窗口；译为“保存并关闭”，避免误解为退出整个程序。 |
| `TabDeleteWithItemsMessage` | 英文、日文、韩文资源使用字面字符 `\n`；当前加载器读取 XML 后直接 `string.Format`，未发现将其转为换行的处理。中文草稿沿用原文中的字面 `\n`，并以“移除其中的项目”描述启动器中的项目。实际显示效果留待实机验证，是否统一调整所有语言格式应另行讨论。 |
| `ToggleSwitchOn` / `ToggleSwitchOff` | 原文为 Yes / No，目前译为“是” / “否”，也可在实机确认视觉语境后讨论“开” / “关”。 |

日文和韩文资源各有 135 条数据、133 个唯一键；`DragDropMessage` 和 `SettingsLanguageDescription` 各出现两次。加载器使用后出现的值，本阶段未改动这两份文件。

新增搜索错误提示沿用原 C# 插值字符串在运行时换行的行为。资源文件保留字面 `\n` 和原有具名占位符，仅使用这些搜索错误模板时恢复原显示效果；其他资源的换行处理未改变。

## 术语

| 英文 | 本稿 | 说明 |
| --- | --- | --- |
| item | 项目 | 启动器中的文件、文件夹、网站等。 |
| tab | 标签页 | 用于分类项目的页面。 |
| group | 分组 | 标签页内的项目分组。 |
| remove | 移除 | 从列表或启动器中移除，不暗示删除磁盘源文件。 |
| delete | 删除 | 标签页等界面对象的删除；不能据此推断删除磁盘源文件。 |
| hotkey | 快捷键 | Global hotkey 为“全局快捷键”。 |
| favicon | 网站图标 | 指缓存的网站图标。 |

## 逐条对照

`↵` 表示实际换行，`\n` 表示文件中原有的两个字符。日文、韩文仅作参考，未翻译或与英文相同的值如实保留。

| 键名 | 英文 | 中文建议 | 日文 | 韩文 |
| --- | --- | --- | --- | --- |
| `AppTitle` | SLauncher - Modern app launcher for Windows | SLauncher - Windows 现代应用启动器 | SLauncher - Windows用モダンアプリランチャー | SLauncher - Windows용 모던 앱 런처 |
| `TrayTooltip` | SLauncher - Double-click to open | SLauncher - 双击打开 | SLauncher - ダブルクリックで開く | SLauncher - 더블클릭하여 열기 |
| `TrayMenuOpen` | Open SLauncher | 打开 SLauncher | SLauncherを開く | SLauncher 열기 |
| `TrayMenuExit` | Exit | 退出 | 終了 | 종료 |
| `SearchPlaceholder` | Search through everything in SLauncher | 搜索 SLauncher 中的所有项目 | SLauncherのすべてを検索 | SLauncher의 모든 항목 검색 |
| `AddFileButton` | Add a file | 添加文件 | ファイル追加 | 파일 추가 |
| `AddFolderButton` | Add a folder | 添加文件夹 | フォルダ追加 | 폴더 추가 |
| `AddWebsiteButton` | Add a website | 添加网站 | サイト追加 | 웹사이트 추가 |
| `EmptyNoticeTitle` | There is nothing here. | 这里空空如也。 | 何もありません。 | 아무것도 없습니다. |
| `EmptyNoticeMessage` | To add an item, click the buttons above, or simply drag them into this window. | 点击上方按钮添加项目，或直接将项目拖入此窗口。 | アイテムを追加するには、上のボタンをクリックするか、このウィンドウにドラッグしてください。 | 항목을 추가하려면 위의 버튼을 클릭하거나 이 창으로 드래그하세요. |
| `LoadingMessage` | Loading your items, please wait... | 正在加载项目，请稍候… | アイテムを読み込んでいます。お待ちください... | 항목을 불러오는 중입니다. 잠시만 기다려주세요... |
| `LoadingWarning` | Please do not close SLauncher. | 请勿关闭 SLauncher。 | SLauncherを閉じないでください。 | SLauncher를 닫지 마세요. |
| `DragDropMessage` | Drag and drop your items here | 将项目拖放到此处 | ここにアイテムをドラッグ | 여기에 항목을 드래그하세요 |
| `TabRename` | Rename | 重命名 | 名前を変更 | 이름 변경 |
| `TabChangeColor` | Change Color | 更改颜色 | 色を変更 | 색 변경 |
| `TabDelete` | Delete | 删除 | 削除 | 삭제 |
| `TabRenameTitle` | Rename Tab | 重命名标签页 | タブ名を変更 | 탭 이름 변경 |
| `TabRenamePlaceholder` | Enter tab name | 输入标签页名称 | タブ名を入力 | 탭 이름 입력 |
| `TabDeleteTitle` | Confirm Tab Deletion | 确认删除标签页 | タブの削除確認 | 탭 삭제 확인 |
| `TabDeleteMessage` | Are you sure you want to delete this tab? | 确定要删除此标签页吗？ | このタブを削除しますか？ | 이 탭을 삭제하시겠습니까? |
| `TabDeleteWithItemsMessage` | This tab contains {0} items.\nDeleting the tab will also delete all items.\n\nAre you sure? | 此标签页包含 {0} 个项目。\n删除标签页也会移除其中的所有项目。\n\n确定要继续吗？ | このタブには{0}個のアイテムがあります。\nタブを削除すると、すべてのアイテムも削除されます。\n\n本当に削除しますか？ | 이 탭에는 {0}개의 항목이 있습니다.\n탭을 삭제하면 모든 항목도 함께 삭제됩니다.\n\n계속 삭제하시겠습니까? |
| `TabCannotDeleteTitle` | Cannot Delete | 无法删除 | 削除できません | 삭제 불가 |
| `TabCannotDeleteMessage` | The last tab cannot be deleted. | 不能删除最后一个标签页。 | 最後のタブは削除できません。 | 마지막 탭은 삭제할 수 없습니다. |
| `DefaultTabName` | Main | 主 | Main | Main |
| `NewTabName` | New Tab {0} | 新标签页 {0} | New Tab {0} | New Tab {0} |
| `ColorDefault` | Default | 默认 | 既定 | 기본 |
| `ColorRed` | Red | 红色 | 赤 | 빨강 |
| `ColorOrange` | Orange | 橙色 | オレンジ | 주황 |
| `ColorYellow` | Yellow | 黄色 | 黄 | 노랑 |
| `ColorGreen` | Green | 绿色 | 緑 | 초록 |
| `ColorBlue` | Blue | 蓝色 | 青 | 파랑 |
| `ColorIndigo` | Indigo | 靛蓝色 | 藍 | 남색 |
| `ColorPurple` | Purple | 紫色 | 紫 | 보라 |
| `ColorPink` | Pink | 粉色 | ピンク | 분홍 |
| `ColorGray` | Gray | 灰色 | 灰色 | 회색 |
| `ButtonOK` | OK | 确定 | OK | 확인 |
| `ButtonCancel` | Cancel | 取消 | キャンセル | 취소 |
| `ButtonDelete` | Delete | 删除 | 削除 | 삭제 |
| `ButtonClose` | Close | 关闭 | 閉じる | 닫기 |
| `SettingsTitle` | Settings | 设置 | 設定 | 설정 |
| `SettingsSubtitle` | Settings are automatically saved once modified. | 更改设置后会自动保存。 | 設定は変更されると自動的に保存されます。 | 설정은 수정되면 자동으로 저장됩니다. |
| `SettingsFullscreenHeader` | Enable fullscreen | 启用全屏 | 全画面表示を有効にする | 전체 화면 사용 |
| `SettingsFullscreenDescription` | Use SLauncher in fullscreen mode. | 以全屏模式使用 SLauncher。 | SLauncherを全画面モードで使用します。 | SLauncher를 전체 화면 모드로 사용합니다. |
| `SettingsGridAlignmentHeader` | Grid alignment | 网格对齐方式 | グリッド配置 | 그리드 정렬 |
| `SettingsGridAlignmentDescription` | Choose how to align the grid where your items are displayed. | 选择项目显示网格的对齐方式。 | アイテムが表示されるグリッドの配置方法を選択します。 | 항목이 표시되는 그리드의 정렬 방식을 선택합니다. |
| `SettingsStartWithWindowsHeader` | Start with Windows | 开机启动 | Windowsと同時に起動 | Windows 시작 시 실행 |
| `SettingsStartWithWindowsDescription` | Launch SLauncher automatically when Windows starts. | Windows 启动时自动运行 SLauncher。 | Windowsの起動時にSLauncherを自動的に起動します。 | Windows가 시작될 때 SLauncher를 자동으로 실행합니다. |
| `SettingsGlobalHotkeyHeader` | Global Hotkey | 全局快捷键 | グローバルホットキー | 전역 단축키 |
| `SettingsGlobalHotkeyDescription` | Press the hotkey anywhere to show/hide SLauncher. Click to change. | 在任意位置按快捷键可显示或隐藏 SLauncher。点击可更改快捷键。 | どこからでもホットキーを押してSLauncherを表示/非表示。クリックして変更。 | 어디서든 단축키를 눌러 SLauncher를 표시/숨김. 클릭하여 변경하세요. |
| `SettingsLanguageHeader` | Language | 语言 | 言語 | 언어 |
| `SettingsLanguageDescription` | Select your preferred language. Requires restart to apply. | 选择首选语言。需要重启才能生效。 | お好みの言語を選択してください | 원하는 언어를 선택하세요 |
| `HotkeyTooltip` | Click to change hotkey | 点击更改快捷键 | クリックしてホットキーを変更 | 클릭하여 단축키 변경 |
| `SettingsBackupRestoreTitle` | Backup & Restore | 备份与还原 | バックアップと復元 | 백업 및 복원 |
| `SettingsBackupRestoreSubtitle` | Settings are stored per-user and don't move with the executable - export them to bring your setup to another PC. | 设置按用户分别保存，不会随可执行文件迁移。若要在其他电脑上使用，请先导出。 | 設定はユーザーごとに保存され、実行ファイルと一緒には移動しません。他のPCに設定を持っていくにはエクスポートしてください。 | 설정은 사용자별로 저장되며 실행 파일과 함께 이동하지 않습니다 - 다른 PC로 옮기려면 내보내기를 사용하세요. |
| `SettingsExportHeader` | Export Settings | 导出设置 | 設定のエクスポート | 설정 내보내기 |
| `SettingsExportDescription` | Save your settings, items and tabs to a single file. | 将设置、项目和标签页保存到一个文件中。 | 設定、アイテム、タブを1つのファイルに保存します。 | 설정, 항목, 탭을 하나의 파일로 저장합니다. |
| `SettingsExportButton` | Export... | 导出… | エクスポート... | 내보내기... |
| `SettingsImportHeader` | Import Settings | 导入设置 | 設定のインポート | 설정 가져오기 |
| `SettingsImportDescription` | Restore settings, items and tabs from an exported file. Requires a restart afterwards. | 从导出的文件中还原设置、项目和标签页。导入后需要重启。 | エクスポートしたファイルから設定、アイテム、タブを復元します。復元後は再起動が必要です。 | 내보낸 파일에서 설정, 항목, 탭을 복원합니다. 이후 재시작이 필요합니다. |
| `SettingsImportButton` | Import... | 导入… | インポート... | 가져오기... |
| `SettingsCacheManagementTitle` | Cache Management | 缓存管理 | キャッシュ管理 | 캐시 관리 |
| `SettingsCacheManagementSubtitle` | Website icons are cached locally on your PC. | 网站图标会缓存在本机。 | ウェブサイトアイコンはこのPCにローカルにキャッシュされます。 | 웹사이트 아이콘은 이 PC에 로컬로 캐시됩니다. |
| `SettingsFaviconCacheHeader` | Favicon Cache | 网站图标缓存 | ファビコンキャッシュ | 파비콘 캐시 |
| `SettingsFaviconCacheDescription` | Cached favicons are stored in UserCache\FaviconCache\ folder. | 网站图标缓存保存在 UserCache\FaviconCache\ 文件夹中。 | キャッシュされたファビコンはUserCache\FaviconCache\フォルダに保存されます。 | 캐시된 파비콘은 UserCache\FaviconCache\ 폴더에 저장됩니다. |
| `SettingsCacheSizeCalculating` | Cache size: Calculating... | 缓存大小：正在计算… | キャッシュサイズ: 計算中... | 캐시 크기: 계산 중... |
| `SettingsCacheSizeFormat` | Cache size: {0} | 缓存大小：{0} | キャッシュサイズ: {0} | 캐시 크기: {0} |
| `CacheSizeEmpty` | Empty | 空 | 空 | 비어 있음 |
| `SettingsClearCacheButton` | Clear Cache | 清除缓存 | キャッシュをクリア | 캐시 지우기 |
| `SettingsCacheLocationHeader` | Cache Location | 缓存位置 | キャッシュの場所 | 캐시 위치 |
| `SettingsCacheLocationDescription` | Cached favicons are stored in a per-user folder, not tied to the executable location. | 网站图标缓存保存在各用户的专用文件夹中，不受可执行文件位置影响。 | キャッシュされたファビコンは、実行ファイルの場所に関係なくユーザーごとのフォルダに保存されます。 | 캐시된 파비콘은 실행 파일 위치와 무관한 사용자별 폴더에 저장됩니다. |
| `SettingsOpenFolderButton` | Open Folder | 打开文件夹 | フォルダを開く | 폴더 열기 |
| `DialogClearCacheTitle` | Clear Cache | 清除缓存 | キャッシュをクリア | 캐시 지우기 |
| `DialogClearCacheContent` | Are you sure you want to clear all cached website icons? They will be downloaded again when needed. | 确定要清除所有缓存的网站图标吗？需要时会重新下载。 | キャッシュされたすべてのウェブサイトアイコンを削除しますか？必要に応じて再ダウンロードされます。 | 캐시된 모든 웹사이트 아이콘을 삭제하시겠습니까? 필요시 다시 다운로드됩니다. |
| `DialogClearCacheConfirm` | Clear | 清除 | クリア | 지우기 |
| `DialogSuccessTitle` | Success | 操作成功 | 成功 | 성공 |
| `DialogCacheCleared` | Cache cleared successfully! | 缓存已清除。 | キャッシュが正常にクリアされました！ | 캐시가 성공적으로 삭제되었습니다! |
| `DialogExportSuccessContent` | Settings exported successfully. | 设置已导出。 | 設定をエクスポートしました。 | 설정을 내보냈습니다. |
| `DialogExportErrorTitle` | Export Failed | 导出失败 | エクスポートに失敗しました | 내보내기 실패 |
| `DialogImportConfirmTitle` | Import Settings? | 导入设置？ | 設定をインポートしますか？ | 설정을 가져올까요? |
| `DialogImportConfirmContent` | This will overwrite your current settings, items and tabs. Continue? | 这将覆盖当前的设置、项目和标签页。是否继续？ | 現在の設定、アイテム、タブが上書きされます。続行しますか？ | 현재 설정, 항목, 탭이 덮어써집니다. 계속할까요? |
| `ButtonImport` | Import | 导入 | インポート | 가져오기 |
| `DialogImportSuccessTitle` | Import Successful | 导入成功 | インポート完了 | 가져오기 완료 |
| `DialogImportSuccessContent` | Settings imported. Please restart SLauncher for the changes to take effect. | 设置已导入。请重启 SLauncher 以使更改生效。 | 設定をインポートしました。変更を反映するにはSLauncherを再起動してください。 | 설정을 가져왔습니다. 변경 사항을 적용하려면 SLauncher를 재시작하세요. |
| `DialogImportErrorTitle` | Import Failed | 导入失败 | インポートに失敗しました | 가져오기 실패 |
| `DialogHotkeyTitle` | Change Global Hotkey | 更改全局快捷键 | グローバルホットキーを変更 | 전역 단축키 변경 |
| `DialogHotkeySave` | Save | 保存 | 保存 | 저장 |
| `DialogRestartTitle` | Restart Required | 需要重启 | 再起動が必要 | 재시작 필요 |
| `DialogRestartContent` | Please restart SLauncher for the hotkey change to take effect. | 请重启 SLauncher 以使快捷键更改生效。 | ホットキーの変更を適用するにはSLauncherを再起動してください。 | 단축키 변경을 적용하려면 SLauncher를 재시작해주세요. |
| `HotkeyModifierLabel` | Modifier Key: | 修饰键： | 修飾キー: | 조합키: |
| `HotkeyKeyLabel` | Key: | 按键： | キー: | 키: |
| `SettingsAboutTitle` | About | 关于 | について | 정보 |
| `SettingsAboutHeader` | About SLauncher | 关于 SLauncher | SLauncherについて | SLauncher 정보 |
| `SettingsAboutDescription` | View info about SLauncher. | 查看 SLauncher 的相关信息。 | SLauncherに関する情報を表示します。 | SLauncher에 대한 정보를 확인합니다. |
| `AboutSubtitle` | Fork of LauncherX with multi-language support | 支持多语言的 LauncherX 分支 | 多言語サポート付きLauncherXのフォーク | 다국어 지원이 추가된 LauncherX의 포크 |
| `AboutVersion` | Version: | 版本： | バージョン: | 버전: |
| `AboutForkBy` | Fork by: | 分支作者： | フォーク作成者: | 포크 작성자: |
| `AboutBasedOn` | Based on: | 基于： | ベース: | 기반: |
| `AboutGitHub` | GitHub: | GitHub： | GitHub: | GitHub: |
| `AboutLicense` | License: | 许可证： | ライセンス: | 라이선스: |
| `AboutViewLicense` | View MIT License | 查看 MIT 许可证 | MITライセンスを表示 | MIT 라이선스 보기 |
| `ToggleSwitchOn` | Yes | 是 | はい | 예 |
| `ToggleSwitchOff` | No | 否 | いいえ | 아니오 |
| `GridAlignmentLeft` | Left | 左对齐 | 左 | 왼쪽 |
| `GridAlignmentCenter` | Center | 居中 | 中央 | 가운데 |
| `SettingsLanguage` | Language | 语言 | 言語 | 언어 |
| `SettingsRestartRequired` | Restart required to apply language changes | 需要重启才能使语言更改生效 | 言語変更を適用するには再起動が必要です | 언어 변경을 적용하려면 재시작이 필요합니다 |
| `TooltipSettings` | Settings | 设置 | 設定 | 설정 |
| `TooltipClose` | Close SLauncher | 关闭 SLauncher | SLauncherを閉じる | SLauncher 닫기 |
| `LoadingTitle` | Loading your items, please wait... | 正在加载项目，请稍候… | アイテムを読み込んでいます... | 항목을 불러오는 중입니다... |
| `LoadingSubtitle` | Please do not close SLauncher. | 请勿关闭 SLauncher。 | SLauncherを閉じないでください。 | SLauncher를 닫지 마세요. |
| `ContextMenu_OpenFile` | Open file | 打开文件 | ファイルを開く | 파일 열기 |
| `ContextMenu_OpenFileLocation` | Open file location | 打开文件所在位置 | ファイルの場所を開く | 파일 위치 열기 |
| `ContextMenu_RemoveFileFromGroup` | Remove file from group | 从分组中移除文件 | グループからファイルを削除 | 그룹에서 파일 제거 |
| `ContextMenu_RemoveFileFromSLauncher` | Remove file from SLauncher | 从 SLauncher 中移除文件 | SLauncherからファイルを削除 | SLauncher에서 파일 제거 |
| `ContextMenu_OpenFolder` | Open folder | 打开文件夹 | フォルダを開く | 폴더 열기 |
| `ContextMenu_OpenFolderLocation` | Open folder location | 打开文件夹所在位置 | フォルダの場所を開く | 폴더 위치 열기 |
| `ContextMenu_RemoveFolderFromGroup` | Remove folder from group | 从分组中移除文件夹 | グループからフォルダを削除 | 그룹에서 폴더 제거 |
| `ContextMenu_RemoveFolderFromSLauncher` | Remove folder from SLauncher | 从 SLauncher 中移除文件夹 | SLauncherからフォルダを削除 | SLauncher에서 폴더 제거 |
| `ContextMenu_OpenWebsite` | Open website | 打开网站 | ウェブサイトを開く | 웹사이트 열기 |
| `ContextMenu_RemoveWebsiteFromGroup` | Remove website from group | 从分组中移除网站 | グループからウェブサイトを削除 | 그룹에서 웹사이트 제거 |
| `ContextMenu_RemoveWebsiteFromSLauncher` | Remove website from SLauncher | 从 SLauncher 中移除网站 | SLauncherからウェブサイトを削除 | SLauncher에서 웹사이트 제거 |
| `ContextMenu_RunAsAdmin` | Attempt to run as administrator | 尝试以管理员身份运行 | 管理者として実行を試みる | 관리자 권한으로 실행 시도 |
| `ContextMenu_EditItem` | Edit item | 编辑项目 | アイテムを編集 | 항목 편집 |
| `EditItem_WindowTitle` | Edit item | 编辑项目 | アイテムを編集 | 항목 편집 |
| `EditItem_EditIconButton` | Edit icon | 编辑图标 | アイコンを編集 | 아이콘 편집 |
| `EditItem_ResetIconButton` | Reset icon | 重置图标 | アイコンをリセット | 아이콘 초기화 |
| `EditItem_DisplayText` | Display Text: | 显示文本： | 表示テキスト: | 표시 텍스트: |
| `EditItem_DisplayTextTooltip` | The text that is displayed on this item in SLauncher. Does not affect what is launched when this item is clicked. | 项目在 SLauncher 中显示的文本。更改此文本不会影响点击项目时启动的内容。 | SLauncherで表示されるテキストです。クリック時に起動されるアイテムには影響しません。 | SLauncher에서 표시되는 텍스트입니다. 클릭 시 실행되는 항목에는 영향을 주지 않습니다. |
| `EditItem_Link` | Link: | 链接： | リンク: | 링크: |
| `EditItem_LinkTooltip` | The actual path or URL that will be launched. Usually same as the display text. | 实际启动的路径或 URL，通常与显示文本相同。 | 実際に起動されるパスまたはURLです。通常は表示テキストと同じです。 | 실제로 실행될 경로 또는 URL입니다. 일반적으로 표시 텍스트와 동일합니다. |
| `EditItem_LaunchArgs` | Launch arguments: | 启动参数： | 起動引数: | 실행 인수: |
| `EditItem_CloseButton` | Close | 关闭 | 閉じる | 닫기 |
| `EditItem_SaveButton` | Save and Exit | 保存并关闭 | 保存して終了 | 저장하고 종료 |
