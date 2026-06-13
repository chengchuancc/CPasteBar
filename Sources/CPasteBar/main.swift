import AppKit
import ApplicationServices
import Carbon

private let appName = "CPasteBar"

private enum AppLanguage: String, CaseIterable {
    case system
    case english
    case simplifiedChinese
    case german
    case japanese
    case french

    var title: String {
        switch self {
        case .system: return Localizer.systemTitle
        case .english: return "English"
        case .simplifiedChinese: return "简体中文"
        case .german: return "Deutsch"
        case .japanese: return "日本語"
        case .french: return "Français"
        }
    }
}

private enum LocalizedTextKey {
    case about
    case autoPasteEnabled
    case autoPasteSetting
    case clearHistory
    case copy
    case delete
    case enableAutoPastePermission
    case globalShortcut
    case historyCapacity
    case language
    case noHistory
    case preferences
    case paste
    case recordShortcut
    case recordingShortcut
    case quit
    case settings
    case systemLanguage
    case untitled
}

private enum Localizer {
    private static let defaultsKey = "appLanguage"

    static var systemTitle: String {
        preferredLanguageCode == "zh" ? "跟随系统" : "System"
    }

    static var language: AppLanguage {
        get {
            guard
                let raw = UserDefaults.standard.string(forKey: defaultsKey),
                let value = AppLanguage(rawValue: raw)
            else { return .system }
            return value
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: defaultsKey)
        }
    }

    static func text(_ key: LocalizedTextKey) -> String {
        switch resolvedLanguage {
        case .simplifiedChinese:
            return chineseText(key)
        case .german:
            return germanText(key)
        case .japanese:
            return japaneseText(key)
        case .french:
            return frenchText(key)
        case .english, .system:
            return englishText(key)
        }
    }

    private static var resolvedLanguage: AppLanguage {
        switch language {
        case .system:
            if preferredLanguageCode == "zh" { return .simplifiedChinese }
            if preferredLanguageCode == "de" { return .german }
            if preferredLanguageCode == "ja" { return .japanese }
            if preferredLanguageCode == "fr" { return .french }
            return .english
        case .english, .simplifiedChinese, .german, .japanese, .french:
            return language
        }
    }

    private static var preferredLanguageCode: String {
        Locale.preferredLanguages.first?.split(separator: "-").first.map(String.init) ?? "en"
    }

    private static func englishText(_ key: LocalizedTextKey) -> String {
        switch key {
        case .about: return "About \(appName)"
        case .autoPasteEnabled: return "Auto Paste Enabled"
        case .autoPasteSetting: return "Paste automatically after choosing an item"
        case .clearHistory: return "Clear History"
        case .copy: return "Copy"
        case .delete: return "Delete"
        case .enableAutoPastePermission: return "Enable Auto Paste Permission..."
        case .globalShortcut: return "Global Shortcut"
        case .historyCapacity: return "History Capacity"
        case .language: return "Language"
        case .noHistory: return "No clipboard history yet"
        case .preferences: return "Preferences..."
        case .paste: return "Paste"
        case .recordShortcut: return "Record Shortcut"
        case .recordingShortcut: return "Press shortcut..."
        case .quit: return "Quit \(appName)"
        case .settings: return "Settings"
        case .systemLanguage: return "System"
        case .untitled: return "Untitled"
        }
    }

    private static func chineseText(_ key: LocalizedTextKey) -> String {
        switch key {
        case .about: return "关于 \(appName)"
        case .autoPasteEnabled: return "自动粘贴已启用"
        case .autoPasteSetting: return "选择条目后自动粘贴"
        case .clearHistory: return "清空历史"
        case .copy: return "复制"
        case .delete: return "删除"
        case .enableAutoPastePermission: return "开启自动粘贴权限..."
        case .globalShortcut: return "全局快捷键"
        case .historyCapacity: return "历史容量"
        case .language: return "语言"
        case .noHistory: return "还没有剪贴板历史"
        case .preferences: return "设置..."
        case .paste: return "粘贴"
        case .recordShortcut: return "录制快捷键"
        case .recordingShortcut: return "请按快捷键..."
        case .quit: return "退出 \(appName)"
        case .settings: return "设置"
        case .systemLanguage: return "跟随系统"
        case .untitled: return "未命名"
        }
    }

    private static func germanText(_ key: LocalizedTextKey) -> String {
        switch key {
        case .about: return "Über \(appName)"
        case .autoPasteEnabled: return "Automatisches Einfügen aktiviert"
        case .autoPasteSetting: return "Nach Auswahl automatisch einfügen"
        case .clearHistory: return "Verlauf löschen"
        case .copy: return "Kopieren"
        case .delete: return "Löschen"
        case .enableAutoPastePermission: return "Berechtigung für automatisches Einfügen aktivieren..."
        case .globalShortcut: return "Globales Tastenkürzel"
        case .historyCapacity: return "Verlaufskapazität"
        case .language: return "Sprache"
        case .noHistory: return "Noch kein Zwischenablageverlauf"
        case .paste: return "Einfügen"
        case .preferences: return "Einstellungen..."
        case .recordShortcut: return "Tastenkürzel aufnehmen"
        case .recordingShortcut: return "Tastenkürzel drücken..."
        case .quit: return "\(appName) beenden"
        case .settings: return "Einstellungen"
        case .systemLanguage: return "System"
        case .untitled: return "Ohne Titel"
        }
    }

    private static func japaneseText(_ key: LocalizedTextKey) -> String {
        switch key {
        case .about: return "\(appName) について"
        case .autoPasteEnabled: return "自動貼り付け有効"
        case .autoPasteSetting: return "項目を選択したら自動で貼り付ける"
        case .clearHistory: return "履歴を消去"
        case .copy: return "コピー"
        case .delete: return "削除"
        case .enableAutoPastePermission: return "自動貼り付け権限を有効にする..."
        case .globalShortcut: return "グローバルショートカット"
        case .historyCapacity: return "履歴件数"
        case .language: return "言語"
        case .noHistory: return "クリップボード履歴はまだありません"
        case .paste: return "貼り付け"
        case .preferences: return "設定..."
        case .recordShortcut: return "ショートカットを記録"
        case .recordingShortcut: return "ショートカットを押してください..."
        case .quit: return "\(appName) を終了"
        case .settings: return "設定"
        case .systemLanguage: return "システム"
        case .untitled: return "名称未設定"
        }
    }

    private static func frenchText(_ key: LocalizedTextKey) -> String {
        switch key {
        case .about: return "À propos de \(appName)"
        case .autoPasteEnabled: return "Collage automatique activé"
        case .autoPasteSetting: return "Coller automatiquement après sélection"
        case .clearHistory: return "Effacer l’historique"
        case .copy: return "Copier"
        case .delete: return "Supprimer"
        case .enableAutoPastePermission: return "Activer l’autorisation de collage..."
        case .globalShortcut: return "Raccourci global"
        case .historyCapacity: return "Capacité de l’historique"
        case .language: return "Langue"
        case .noHistory: return "Aucun historique du presse-papiers"
        case .paste: return "Coller"
        case .preferences: return "Préférences..."
        case .recordShortcut: return "Enregistrer le raccourci"
        case .recordingShortcut: return "Appuyez sur le raccourci..."
        case .quit: return "Quitter \(appName)"
        case .settings: return "Réglages"
        case .systemLanguage: return "Système"
        case .untitled: return "Sans titre"
        }
    }
}

private enum Preferences {
    private static let autoPasteKey = "autoPasteEnabled"
    private static let historyCapacityKey = "historyCapacity"

    static var autoPasteEnabled: Bool {
        get {
            if UserDefaults.standard.object(forKey: autoPasteKey) == nil {
                return true
            }
            return UserDefaults.standard.bool(forKey: autoPasteKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: autoPasteKey)
        }
    }

    static var historyCapacity: Int {
        get {
            let value = UserDefaults.standard.integer(forKey: historyCapacityKey)
            return [10, 25, 50, 100].contains(value) ? value : 50
        }
        set {
            UserDefaults.standard.set(newValue, forKey: historyCapacityKey)
        }
    }
}

private struct ClipboardEntry: Codable, Equatable {
    let text: String
    let createdAt: Date
}

private final class HistoryStore {
    private let fileURL: URL

    private(set) var entries: [ClipboardEntry] = []

    init() {
        let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let directory = support.appendingPathComponent(appName, isDirectory: true)
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        fileURL = directory.appendingPathComponent("history.json")
        load()
    }

    func add(_ text: String) {
        let cleaned = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleaned.isEmpty else { return }

        entries.removeAll { $0.text == text }
        entries.insert(ClipboardEntry(text: text, createdAt: Date()), at: 0)
        trimToCapacity()
        save()
    }

    func delete(_ text: String) {
        entries.removeAll { $0.text == text }
        save()
    }

    func clear() {
        entries.removeAll()
        save()
    }

    func trimToCapacity() {
        if entries.count > Preferences.historyCapacity {
            entries = Array(entries.prefix(Preferences.historyCapacity))
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        entries = (try? JSONDecoder().decode([ClipboardEntry].self, from: data)) ?? []
        trimToCapacity()
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }
}

private struct KeyboardShortcut: Codable, Equatable {
    let keyCode: UInt32
    let carbonModifiers: UInt32
    let keyEquivalent: String

    static let defaultShortcut = KeyboardShortcut(
        keyCode: UInt32(kVK_ANSI_V),
        carbonModifiers: UInt32(cmdKey | shiftKey),
        keyEquivalent: "V"
    )

    var title: String {
        var parts: [String] = []
        if carbonModifiers & UInt32(controlKey) != 0 { parts.append("Control") }
        if carbonModifiers & UInt32(optionKey) != 0 { parts.append("Option") }
        if carbonModifiers & UInt32(shiftKey) != 0 { parts.append("Shift") }
        if carbonModifiers & UInt32(cmdKey) != 0 { parts.append("Command") }
        parts.append(keyEquivalent.uppercased())
        return parts.joined(separator: "-")
    }

    var isValid: Bool {
        let required = UInt32(cmdKey | optionKey | controlKey)
        return carbonModifiers & required != 0
    }

    init(keyCode: UInt32, carbonModifiers: UInt32, keyEquivalent: String) {
        self.keyCode = keyCode
        self.carbonModifiers = carbonModifiers
        self.keyEquivalent = keyEquivalent.isEmpty ? "Key \(keyCode)" : keyEquivalent
    }

    init?(event: NSEvent) {
        let modifiers = Self.carbonModifiers(from: event.modifierFlags)
        let key = event.charactersIgnoringModifiers?.uppercased() ?? ""
        let shortcut = KeyboardShortcut(
            keyCode: UInt32(event.keyCode),
            carbonModifiers: modifiers,
            keyEquivalent: Self.displayKey(for: event.keyCode, fallback: key)
        )
        guard shortcut.isValid else { return nil }
        self = shortcut
    }

    private static func carbonModifiers(from flags: NSEvent.ModifierFlags) -> UInt32 {
        var result: UInt32 = 0
        if flags.contains(.command) { result |= UInt32(cmdKey) }
        if flags.contains(.option) { result |= UInt32(optionKey) }
        if flags.contains(.control) { result |= UInt32(controlKey) }
        if flags.contains(.shift) { result |= UInt32(shiftKey) }
        return result
    }

    private static func displayKey(for keyCode: UInt16, fallback: String) -> String {
        if !fallback.isEmpty {
            return fallback
        }

        switch Int(keyCode) {
        case kVK_Space: return "Space"
        case kVK_Return: return "Return"
        case kVK_Tab: return "Tab"
        case kVK_Escape: return "Escape"
        case kVK_Delete: return "Delete"
        case kVK_ForwardDelete: return "Forward Delete"
        case kVK_LeftArrow: return "Left"
        case kVK_RightArrow: return "Right"
        case kVK_UpArrow: return "Up"
        case kVK_DownArrow: return "Down"
        default: return "Key \(keyCode)"
        }
    }
}

private extension String {
    var fourCharCode: FourCharCode {
        unicodeScalars.reduce(0) { ($0 << 8) + FourCharCode($1.value) }
    }
}

private final class ShortcutController: @unchecked Sendable {
    private var hotKeyRef: EventHotKeyRef?
    private var eventHandler: EventHandlerRef?
    private let defaultsKey = "keyboardShortcut"
    private let callback: () -> Void
    private var isSuspended = false

    var shortcut: KeyboardShortcut {
        get {
            guard
                let data = UserDefaults.standard.data(forKey: defaultsKey),
                let value = try? JSONDecoder().decode(KeyboardShortcut.self, from: data)
            else { return .defaultShortcut }
            return value
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: defaultsKey)
            }
            if !isSuspended {
                register()
            }
        }
    }

    init(callback: @escaping () -> Void) {
        self.callback = callback
        installHandler()
        register()
    }

    deinit {
        if let hotKeyRef {
            UnregisterEventHotKey(hotKeyRef)
        }
        if let eventHandler {
            RemoveEventHandler(eventHandler)
        }
    }

    private func installHandler() {
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))
        let selfPointer = Unmanaged.passUnretained(self).toOpaque()

        InstallEventHandler(
            GetApplicationEventTarget(),
            { _, event, userData in
                guard let event, let userData else { return noErr }

                var hotKeyID = EventHotKeyID()
                GetEventParameter(
                    event,
                    EventParamName(kEventParamDirectObject),
                    EventParamType(typeEventHotKeyID),
                    nil,
                    MemoryLayout<EventHotKeyID>.size,
                    nil,
                    &hotKeyID
                )

                guard hotKeyID.signature == "CPBV".fourCharCode else { return noErr }
                let controller = Unmanaged<ShortcutController>.fromOpaque(userData).takeUnretainedValue()
                DispatchQueue.main.async {
                    controller.callback()
                }
                return noErr
            },
            1,
            &eventType,
            selfPointer,
            &eventHandler
        )
    }

    func register() {
        if let hotKeyRef {
            UnregisterEventHotKey(hotKeyRef)
            self.hotKeyRef = nil
        }

        let hotKeyID = EventHotKeyID(signature: "CPBV".fourCharCode, id: 1)
        RegisterEventHotKey(
            shortcut.keyCode,
            shortcut.carbonModifiers,
            hotKeyID,
            GetApplicationEventTarget(),
            0,
            &hotKeyRef
        )
    }

    func suspend() {
        isSuspended = true
        if let hotKeyRef {
            UnregisterEventHotKey(hotKeyRef)
            self.hotKeyRef = nil
        }
    }

    func resume() {
        isSuspended = false
        register()
    }
}

@MainActor
private final class FlippedView: NSView {
    override var isFlipped: Bool {
        true
    }
}

@MainActor
private final class HistoryRowView: NSView {
    private let text: String
    private let rowWidth: CGFloat
    private let onCopy: (String) -> Void
    private let onPaste: (String) -> Void
    private let onDelete: (String) -> Void

    init(text: String, width: CGFloat, onCopy: @escaping (String) -> Void, onPaste: @escaping (String) -> Void, onDelete: @escaping (String) -> Void) {
        self.text = text
        self.rowWidth = width
        self.onCopy = onCopy
        self.onPaste = onPaste
        self.onDelete = onDelete
        super.init(frame: NSRect(x: 0, y: 0, width: width, height: 34))
        build()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: NSSize {
        NSSize(width: rowWidth, height: 34)
    }

    private func build() {
        let label = NSTextField(labelWithString: displayTitle(for: text))
        label.lineBreakMode = .byTruncatingTail
        label.maximumNumberOfLines = 1
        label.font = .systemFont(ofSize: 13)
        label.textColor = .labelColor
        label.toolTip = text
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let pasteButton = NSButton(title: "", target: self, action: #selector(paste))
        pasteButton.bezelStyle = .inline
        pasteButton.isBordered = false
        pasteButton.setButtonType(.momentaryChange)
        pasteButton.toolTip = text

        let copyButton = iconButton(symbol: "doc.on.doc", label: Localizer.text(.copy), action: #selector(copyItem))
        let explicitPasteButton = iconButton(symbol: "arrow.down.doc", label: Localizer.text(.paste), action: #selector(paste))
        let deleteButton = iconButton(symbol: "trash", label: Localizer.text(.delete), action: #selector(deleteItem))
        deleteButton.bezelStyle = .inline

        addSubview(pasteButton)
        addSubview(label)
        addSubview(copyButton)
        addSubview(explicitPasteButton)
        addSubview(deleteButton)
        pasteButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        explicitPasteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: rowWidth),
            heightAnchor.constraint(equalToConstant: 34),

            pasteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            pasteButton.topAnchor.constraint(equalTo: topAnchor),
            pasteButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            pasteButton.trailingAnchor.constraint(equalTo: copyButton.leadingAnchor, constant: -8),

            label.leadingAnchor.constraint(equalTo: pasteButton.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: pasteButton.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),

            copyButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            copyButton.widthAnchor.constraint(equalToConstant: 28),
            copyButton.heightAnchor.constraint(equalToConstant: 28),
            copyButton.trailingAnchor.constraint(equalTo: explicitPasteButton.leadingAnchor, constant: -4),

            explicitPasteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            explicitPasteButton.widthAnchor.constraint(equalToConstant: 28),
            explicitPasteButton.heightAnchor.constraint(equalToConstant: 28),
            explicitPasteButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -4),

            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 28),
            deleteButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func iconButton(symbol: String, label: String, action: Selector) -> NSButton {
        let button = NSButton(image: NSImage(systemSymbolName: symbol, accessibilityDescription: label) ?? NSImage(), target: self, action: action)
        button.bezelStyle = .regularSquare
        button.isBordered = false
        button.contentTintColor = .secondaryLabelColor
        button.toolTip = label
        return button
    }

    private func displayTitle(for text: String) -> String {
        let singleLine = text
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\t", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        return singleLine.isEmpty ? Localizer.text(.untitled) : singleLine
    }

    @objc private func paste() {
        onPaste(text)
    }

    @objc private func copyItem() {
        onCopy(text)
    }

    @objc private func deleteItem() {
        onDelete(text)
    }
}

@MainActor
private final class HistoryPanel: NSPanel {
    init() {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 430, height: 380),
            styleMask: [.nonactivatingPanel, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        isFloatingPanel = true
        level = .floating
        hidesOnDeactivate = false
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        backgroundColor = .clear
        isOpaque = false
        hasShadow = true
    }

    override var canBecomeKey: Bool {
        true
    }
}

@MainActor
private final class HistoryPopupView: NSView {
    private let stack = NSStackView()
    private let onCopy: (String) -> Void
    private let onPaste: (String) -> Void
    private let onDelete: (String) -> Void
    private let onClose: () -> Void

    init(entries: [ClipboardEntry], shortcutTitle: String, onCopy: @escaping (String) -> Void, onPaste: @escaping (String) -> Void, onDelete: @escaping (String) -> Void, onClose: @escaping () -> Void) {
        self.onCopy = onCopy
        self.onPaste = onPaste
        self.onDelete = onDelete
        self.onClose = onClose
        super.init(frame: NSRect(x: 0, y: 0, width: 430, height: 380))
        build(entries: entries, shortcutTitle: shortcutTitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func build(entries: [ClipboardEntry], shortcutTitle: String) {
        wantsLayer = true
        layer?.cornerRadius = 12
        layer?.backgroundColor = NSColor.windowBackgroundColor.withAlphaComponent(0.995).cgColor
        layer?.borderColor = NSColor.separatorColor.cgColor
        layer?.borderWidth = 1

        let header = NSTextField(labelWithString: appName)
        header.font = .systemFont(ofSize: 14, weight: .semibold)
        header.textColor = .labelColor

        let hint = NSTextField(labelWithString: shortcutTitle)
        hint.font = .systemFont(ofSize: 12)
        hint.textColor = .secondaryLabelColor
        hint.alignment = .right

        let closeButton = NSButton(image: NSImage(systemSymbolName: "xmark.circle.fill", accessibilityDescription: "Close") ?? NSImage(), target: self, action: #selector(close))
        closeButton.bezelStyle = .inline
        closeButton.isBordered = false
        closeButton.contentTintColor = .secondaryLabelColor
        closeButton.toolTip = "Close"

        let headerCenter = NSStackView(views: [header, hint])
        headerCenter.orientation = .horizontal
        headerCenter.alignment = .centerY
        headerCenter.spacing = 12

        let headerRow = NSView()
        headerRow.addSubview(headerCenter)
        headerRow.addSubview(closeButton)
        headerCenter.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerRow.heightAnchor.constraint(equalToConstant: 34),
            headerCenter.centerXAnchor.constraint(equalTo: headerRow.centerXAnchor),
            headerCenter.centerYAnchor.constraint(equalTo: headerRow.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: headerRow.trailingAnchor, constant: -2),
            closeButton.centerYAnchor.constraint(equalTo: headerRow.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 28),
            closeButton.heightAnchor.constraint(equalToConstant: 28)
        ])

        stack.orientation = .vertical
        stack.spacing = 0
        stack.edgeInsets = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        stack.addArrangedSubview(headerRow)
        stack.addArrangedSubview(separator())

        if entries.isEmpty {
            let empty = NSTextField(labelWithString: Localizer.text(.noHistory))
            empty.font = .systemFont(ofSize: 13)
            empty.textColor = .secondaryLabelColor
            empty.alignment = .center
            empty.heightAnchor.constraint(equalToConstant: 86).isActive = true
            stack.addArrangedSubview(empty)
            return
        }

        let scrollView = NSScrollView()
        scrollView.drawsBackground = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.borderType = .noBorder

        let rowHeight: CGFloat = 34
        let rowWidth: CGFloat = 400
        let documentHeight = CGFloat(entries.count) * rowHeight
        let documentView = FlippedView(frame: NSRect(x: 0, y: 0, width: rowWidth, height: documentHeight))

        for (index, entry) in entries.enumerated() {
            let row = HistoryRowView(text: entry.text, width: rowWidth, onCopy: onCopy, onPaste: onPaste, onDelete: onDelete)
            row.frame = NSRect(x: 0, y: CGFloat(index) * rowHeight, width: rowWidth, height: rowHeight)
            documentView.addSubview(row)
        }

        scrollView.documentView = documentView
        scrollView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        stack.addArrangedSubview(scrollView)
    }

    private func separator() -> NSBox {
        let box = NSBox()
        box.boxType = .separator
        return box
    }

    override func keyDown(with event: NSEvent) {
        if event.keyCode == UInt16(kVK_Escape) {
            onClose()
        } else {
            super.keyDown(with: event)
        }
    }

    @objc private func close() {
        onClose()
    }
}

@MainActor
private final class ShortcutRecorderButton: NSButton {
    private var monitor: Any?
    private let onRecord: (KeyboardShortcut) -> Void
    private let onRecordingChanged: (Bool) -> Void

    init(onRecord: @escaping (KeyboardShortcut) -> Void, onRecordingChanged: @escaping (Bool) -> Void) {
        self.onRecord = onRecord
        self.onRecordingChanged = onRecordingChanged
        super.init(frame: .zero)
        bezelStyle = .rounded
        target = self
        action = #selector(startRecording)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        MainActor.assumeIsolated {
            stopRecording()
        }
    }

    func setShortcut(_ shortcut: KeyboardShortcut) {
        title = shortcut.title
    }

    @objc private func startRecording() {
        title = Localizer.text(.recordingShortcut)
        window?.makeFirstResponder(self)
        stopRecording()
        onRecordingChanged(true)
        monitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self else { return event }
            if event.keyCode == UInt16(kVK_Escape) {
                self.stopRecording()
                return nil
            }
            guard let shortcut = KeyboardShortcut(event: event) else {
                NSSound.beep()
                return nil
            }
            self.onRecord(shortcut)
            self.stopRecording()
            return nil
        }
    }

    private func stopRecording() {
        if let monitor {
            NSEvent.removeMonitor(monitor)
            self.monitor = nil
            onRecordingChanged(false)
        }
    }
}

@MainActor
private final class PreferencesWindowController: NSWindowController {
    private let onChange: () -> Void
    private let shortcutController: ShortcutController
    private let store: HistoryStore

    private let languagePopup = NSPopUpButton()
    private lazy var shortcutRecorder = ShortcutRecorderButton { [weak self] shortcut in
        self?.shortcutController.shortcut = shortcut
        self?.reload()
        self?.onChange()
    } onRecordingChanged: { [weak self] isRecording in
        if isRecording {
            self?.shortcutController.suspend()
        } else {
            self?.shortcutController.resume()
        }
    }
    private let capacityPopup = NSPopUpButton()
    private let autoPasteCheckbox = NSButton(checkboxWithTitle: "", target: nil, action: nil)

    init(shortcutController: ShortcutController, store: HistoryStore, onChange: @escaping () -> Void) {
        self.shortcutController = shortcutController
        self.store = store
        self.onChange = onChange
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 460, height: 270),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "\(appName) \(Localizer.text(.settings))"
        super.init(window: window)
        window.contentView = buildView()
        reload()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reload() {
        window?.title = "\(appName) \(Localizer.text(.settings))"
        autoPasteCheckbox.title = Localizer.text(.autoPasteSetting)
        autoPasteCheckbox.state = Preferences.autoPasteEnabled ? .on : .off

        languagePopup.removeAllItems()
        for language in AppLanguage.allCases {
            languagePopup.addItem(withTitle: language.title)
            languagePopup.lastItem?.representedObject = language.rawValue
        }
        languagePopup.selectItem(withTitle: Localizer.language.title)

        shortcutRecorder.setShortcut(shortcutController.shortcut)

        capacityPopup.removeAllItems()
        for capacity in [10, 25, 50, 100] {
            capacityPopup.addItem(withTitle: "\(capacity)")
            capacityPopup.lastItem?.representedObject = capacity
        }
        capacityPopup.selectItem(withTitle: "\(Preferences.historyCapacity)")
    }

    private func buildView() -> NSView {
        let root = NSView()

        let title = NSTextField(labelWithString: appName)
        title.font = .systemFont(ofSize: 22, weight: .semibold)

        let form = NSGridView(views: [
            [label(.language), languagePopup],
            [label(.globalShortcut), shortcutRecorder],
            [label(.historyCapacity), capacityPopup]
        ])
        form.column(at: 0).xPlacement = .trailing
        form.column(at: 1).xPlacement = .fill
        form.rowSpacing = 14
        form.columnSpacing = 14

        autoPasteCheckbox.target = self
        autoPasteCheckbox.action = #selector(toggleAutoPaste(_:))

        languagePopup.target = self
        languagePopup.action = #selector(changeLanguage(_:))
        capacityPopup.target = self
        capacityPopup.action = #selector(changeCapacity(_:))

        let stack = NSStackView(views: [title, form, autoPasteCheckbox])
        stack.orientation = .vertical
        stack.alignment = .leading
        stack.spacing = 18
        stack.edgeInsets = NSEdgeInsets(top: 26, left: 28, bottom: 24, right: 28)

        root.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: root.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: root.trailingAnchor),
            stack.topAnchor.constraint(equalTo: root.topAnchor),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: root.bottomAnchor)
        ])

        return root
    }

    private func label(_ key: LocalizedTextKey) -> NSTextField {
        let field = NSTextField(labelWithString: Localizer.text(key))
        field.font = .systemFont(ofSize: 13, weight: .medium)
        field.textColor = .secondaryLabelColor
        return field
    }

    @objc private func changeLanguage(_ sender: NSPopUpButton) {
        guard
            let raw = sender.selectedItem?.representedObject as? String,
            let language = AppLanguage(rawValue: raw)
        else { return }
        Localizer.language = language
        reload()
        onChange()
    }

    @objc private func changeCapacity(_ sender: NSPopUpButton) {
        guard let capacity = sender.selectedItem?.representedObject as? Int else { return }
        Preferences.historyCapacity = capacity
        store.trimToCapacity()
        onChange()
    }

    @objc private func toggleAutoPaste(_ sender: NSButton) {
        Preferences.autoPasteEnabled = sender.state == .on
        onChange()
    }
}

@MainActor
private final class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    private let pasteboard = NSPasteboard.general
    private let store = HistoryStore()
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private var changeCount = NSPasteboard.general.changeCount
    private var ignoredClipboardText: String?
    private var timer: Timer?
    private weak var targetApp: NSRunningApplication?
    private weak var lastActiveApp: NSRunningApplication?
    private var shortcutController: ShortcutController?
    private var popupPanel: HistoryPanel?
    private var preferencesWindowController: PreferencesWindowController?
    private var popupCloseMonitor: Any?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        configureStatusItem()
        refreshMenu()
        startMonitoring()
        observeActiveApplications()
        shortcutController = ShortcutController { [weak self] in
            self?.showHistoryPopup()
        }
    }

    private func configureStatusItem() {
        statusItem.length = NSStatusItem.squareLength
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "doc.on.clipboard", accessibilityDescription: appName)
                ?? NSImage(systemSymbolName: "clipboard", accessibilityDescription: appName)
            button.image?.isTemplate = true
            button.toolTip = appName
        }
    }

    private func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.checkPasteboard()
            }
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    private func observeActiveApplications() {
        updateLastActiveApp(NSWorkspace.shared.frontmostApplication)
        NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didActivateApplicationNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            guard let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication else { return }
            Task { @MainActor in
                self?.updateLastActiveApp(app)
            }
        }
    }

    private func updateLastActiveApp(_ app: NSRunningApplication?) {
        guard
            let app,
            app.processIdentifier != NSRunningApplication.current.processIdentifier
        else { return }
        lastActiveApp = app
    }

    private func checkPasteboard() {
        guard pasteboard.changeCount != changeCount else { return }
        changeCount = pasteboard.changeCount

        if let text = pasteboard.string(forType: .string) {
            if text == ignoredClipboardText {
                ignoredClipboardText = nil
                return
            }
            store.add(text)
            refreshMenu()
            refreshPopupIfVisible()
        }
    }

    private func refreshMenu() {
        let menu = NSMenu()
        menu.delegate = self

        let title = NSMenuItem(title: appName, action: nil, keyEquivalent: "")
        title.isEnabled = false
        menu.addItem(title)
        menu.addItem(.separator())

        if store.entries.isEmpty {
            let empty = NSMenuItem(title: Localizer.text(.noHistory), action: nil, keyEquivalent: "")
            empty.isEnabled = false
            menu.addItem(empty)
        } else {
            for entry in store.entries.prefix(10) {
                let item = NSMenuItem()
                item.view = HistoryRowView(
                    text: entry.text,
                    width: 370,
                    onCopy: { [weak self] text in
                        self?.copyTextWithoutRecording(text)
                    },
                    onPaste: { [weak self] text in
                        self?.statusItem.menu?.cancelTracking()
                        self?.pasteText(text)
                    },
                    onDelete: { [weak self] text in
                        self?.statusItem.menu?.cancelTracking()
                        self?.deleteText(text)
                    }
                )
                menu.addItem(item)
            }

            if store.entries.count > 10 {
                let more = NSMenuItem(title: "\(Localizer.text(.globalShortcut)): \(shortcutController?.shortcut.title ?? KeyboardShortcut.defaultShortcut.title)", action: #selector(showHistoryPopupFromMenu), keyEquivalent: "")
                more.target = self
                menu.addItem(more)
            }
        }

        menu.addItem(.separator())

        let accessibility = NSMenuItem(
            title: AXIsProcessTrusted() ? Localizer.text(.autoPasteEnabled) : Localizer.text(.enableAutoPastePermission),
            action: AXIsProcessTrusted() ? nil : #selector(requestAccessibilityPermission),
            keyEquivalent: ""
        )
        accessibility.target = self
        accessibility.isEnabled = !AXIsProcessTrusted()
        menu.addItem(accessibility)

        let shortcutTitle = shortcutController?.shortcut.title ?? KeyboardShortcut.defaultShortcut.title
        let shortcut = NSMenuItem(title: "\(Localizer.text(.globalShortcut)): \(shortcutTitle)", action: #selector(openPreferences), keyEquivalent: "")
        shortcut.target = self
        menu.addItem(shortcut)

        let languageMenu = NSMenu()
        for language in AppLanguage.allCases {
            let item = NSMenuItem(title: language.title, action: #selector(setLanguage(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = language.rawValue
            item.state = Localizer.language == language ? .on : .off
            languageMenu.addItem(item)
        }
        let language = NSMenuItem(title: Localizer.text(.language), action: nil, keyEquivalent: "")
        language.submenu = languageMenu
        menu.addItem(language)

        let preferences = NSMenuItem(title: Localizer.text(.preferences), action: #selector(openPreferences), keyEquivalent: ",")
        preferences.target = self
        menu.addItem(preferences)

        let clear = NSMenuItem(title: Localizer.text(.clearHistory), action: #selector(clearHistory), keyEquivalent: "")
        clear.target = self
        clear.isEnabled = !store.entries.isEmpty
        menu.addItem(clear)

        menu.addItem(.separator())

        let about = NSMenuItem(title: Localizer.text(.about), action: #selector(showAbout), keyEquivalent: "")
        about.target = self
        menu.addItem(about)

        let quit = NSMenuItem(title: Localizer.text(.quit), action: #selector(quit), keyEquivalent: "q")
        quit.target = self
        menu.addItem(quit)

        statusItem.menu = menu
    }

    func menuWillOpen(_ menu: NSMenu) {
        updateLastActiveApp(NSWorkspace.shared.frontmostApplication)
        targetApp = lastActiveApp
    }

    private func pasteText(_ text: String, forceAutoPaste: Bool = false) {
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
        changeCount = pasteboard.changeCount
        store.add(text)
        refreshMenu()
        refreshPopupIfVisible()

        guard forceAutoPaste || Preferences.autoPasteEnabled else { return }

        let appToActivate = targetApp ?? lastActiveApp
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            self.sendPasteShortcut(to: appToActivate, text: text)
        }
    }

    private func copyTextWithoutRecording(_ text: String) {
        ignoredClipboardText = text
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
        changeCount = pasteboard.changeCount
    }

    private func deleteText(_ text: String) {
        store.delete(text)
        refreshMenu()
        refreshPopupIfVisible()
    }

    private func showHistoryPopup() {
        updateLastActiveApp(NSWorkspace.shared.frontmostApplication)
        targetApp = lastActiveApp

        let panel = popupPanel ?? HistoryPanel()
        popupPanel = panel
        panel.contentView = HistoryPopupView(
            entries: store.entries,
            shortcutTitle: shortcutController?.shortcut.title ?? KeyboardShortcut.defaultShortcut.title,
            onCopy: { [weak self] text in
                self?.copyTextWithoutRecording(text)
            },
            onPaste: { [weak self] text in
                self?.closePopup()
                self?.pasteText(text, forceAutoPaste: true)
            },
            onDelete: { [weak self] text in
                self?.deleteText(text)
            },
            onClose: { [weak self] in
                self?.closePopup()
            }
        )

        let mouse = NSEvent.mouseLocation
        let screenFrame = NSScreen.screens.first { NSMouseInRect(mouse, $0.frame, false) }?.visibleFrame ?? NSScreen.main?.visibleFrame ?? .zero
        let panelHeight: CGFloat = store.entries.isEmpty ? 170 : 360
        panel.setContentSize(NSSize(width: 430, height: panelHeight))
        let size = panel.frame.size
        let origin = NSPoint(
            x: min(max(mouse.x - 24, screenFrame.minX + 8), screenFrame.maxX - size.width - 8),
            y: min(max(mouse.y - size.height + 24, screenFrame.minY + 8), screenFrame.maxY - size.height - 8)
        )
        panel.setFrameOrigin(origin)
        panel.orderFrontRegardless()
        installPopupCloseMonitor(for: panel)
    }

    private func refreshPopupIfVisible() {
        guard popupPanel?.isVisible == true else { return }
        showHistoryPopup()
    }

    private func closePopup() {
        popupPanel?.orderOut(nil)
        if let popupCloseMonitor {
            NSEvent.removeMonitor(popupCloseMonitor)
            self.popupCloseMonitor = nil
        }
    }

    private func installPopupCloseMonitor(for panel: NSPanel) {
        if let popupCloseMonitor {
            NSEvent.removeMonitor(popupCloseMonitor)
            self.popupCloseMonitor = nil
        }

        popupCloseMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self, weak panel] event in
            guard let self, let panel else { return }
            let clickPoint = NSEvent.mouseLocation
            Task { @MainActor in
                if !panel.frame.contains(clickPoint) {
                    self.closePopup()
                }
            }
        }
    }

    private func sendPasteShortcut(to app: NSRunningApplication?, text: String) {
        guard AXIsProcessTrusted() else {
            NSSound.beep()
            return
        }

        app?.activate()
        Thread.sleep(forTimeInterval: 0.2)

        if insertTextWithAccessibility(text) {
            return
        }

        if runSystemEventsPaste(to: app) {
            return
        }

        let source = CGEventSource(stateID: .hidSystemState)
        let keyDown = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: true)
        let keyUp = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: false)
        keyDown?.flags = .maskCommand
        keyUp?.flags = .maskCommand

        keyDown?.post(tap: .cghidEventTap)
        keyUp?.post(tap: .cghidEventTap)
    }

    private func insertTextWithAccessibility(_ text: String) -> Bool {
        let system = AXUIElementCreateSystemWide()
        var focusedObject: CFTypeRef?
        guard AXUIElementCopyAttributeValue(system, kAXFocusedUIElementAttribute as CFString, &focusedObject) == .success,
              let focusedObject else {
            return false
        }

        let focusedElement = focusedObject as! AXUIElement
        if AXUIElementSetAttributeValue(focusedElement, kAXSelectedTextAttribute as CFString, text as CFString) == .success {
            return true
        }

        var rangeObject: CFTypeRef?
        var valueObject: CFTypeRef?
        guard AXUIElementCopyAttributeValue(focusedElement, kAXSelectedTextRangeAttribute as CFString, &rangeObject) == .success,
              AXUIElementCopyAttributeValue(focusedElement, kAXValueAttribute as CFString, &valueObject) == .success,
              let rangeObject,
              let currentText = valueObject as? String else {
            return false
        }

        var selectedRange = CFRange()
        guard AXValueGetType(rangeObject as! AXValue) == .cfRange,
              AXValueGetValue(rangeObject as! AXValue, .cfRange, &selectedRange) else {
            return false
        }

        let nsRange = NSRange(location: selectedRange.location, length: selectedRange.length)
        let updatedText = (currentText as NSString).replacingCharacters(in: nsRange, with: text)
        guard AXUIElementSetAttributeValue(focusedElement, kAXValueAttribute as CFString, updatedText as CFString) == .success else {
            return false
        }

        var newRange = CFRange(location: selectedRange.location + text.utf16.count, length: 0)
        if let newRangeValue = AXValueCreate(.cfRange, &newRange) {
            AXUIElementSetAttributeValue(focusedElement, kAXSelectedTextRangeAttribute as CFString, newRangeValue)
        }
        return true
    }

    private func runSystemEventsPaste(to app: NSRunningApplication?) -> Bool {
        let activateLine: String
        if let bundleIdentifier = app?.bundleIdentifier {
            activateLine = "tell application id \"\(bundleIdentifier)\" to activate"
        } else if let appName = app?.localizedName {
            activateLine = "tell application \"\(appName.replacingOccurrences(of: "\"", with: "\\\""))\" to activate"
        } else {
            activateLine = ""
        }

        let scriptSource = """
        \(activateLine)
        delay 0.2
        tell application "System Events"
            keystroke "v" using command down
        end tell
        """

        var error: NSDictionary?
        guard let script = NSAppleScript(source: scriptSource) else { return false }
        script.executeAndReturnError(&error)
        return error == nil
    }

    @objc private func requestAccessibilityPermission() {
        let options: NSDictionary = ["AXTrustedCheckOptionPrompt": true]
        _ = AXIsProcessTrustedWithOptions(options)
        NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")!)
    }

    @objc private func clearHistory() {
        store.clear()
        refreshMenu()
        refreshPopupIfVisible()
    }

    @objc private func showHistoryPopupFromMenu() {
        statusItem.menu?.cancelTracking()
        showHistoryPopup()
    }

    @objc private func setLanguage(_ sender: NSMenuItem) {
        guard
            let raw = sender.representedObject as? String,
            let language = AppLanguage(rawValue: raw)
        else { return }

        Localizer.language = language
        refreshMenu()
        refreshPopupIfVisible()
        preferencesWindowController?.reload()
    }

    @objc private func openPreferences() {
        if preferencesWindowController == nil, let shortcutController {
            preferencesWindowController = PreferencesWindowController(
                shortcutController: shortcutController,
                store: store,
                onChange: { [weak self] in
                    self?.refreshMenu()
                    self?.refreshPopupIfVisible()
                }
            )
        }

        preferencesWindowController?.reload()
        preferencesWindowController?.showWindow(nil)
        preferencesWindowController?.window?.makeKeyAndOrderFront(nil)
        NSApp.activate()
    }

    @objc private func showAbout() {
        NSApp.orderFrontStandardAboutPanel(options: [
            .applicationName: appName,
            .applicationVersion: "0.1.0",
            .credits: NSAttributedString(string: "Clipboard history, quick paste, configurable shortcuts, and multilingual UI.\n\nCopyright © chengchuan")
        ])
    }

    @objc private func quit() {
        NSApp.terminate(nil)
    }
}

let app = NSApplication.shared
private let delegate = AppDelegate()
app.delegate = delegate
app.run()
