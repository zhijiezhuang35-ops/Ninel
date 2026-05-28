import Foundation

struct NotePetal: Codable, Equatable {
    let pageInk: String // 话题唯一 id
    var folioThread: String // 所属用户 id
    var pageWhisper: String // 话题标题
    var lineThread: String // 话题内容
    var tagEcho: String // 话题分类
    var echoLinks: [String] // 关联人物 id
    var noteMoment: TimeInterval // 创建时间戳

    var timeWhisper: String { // 动态时间显示
        let noteGap = max(0, Int(Date().timeIntervalSince1970 - noteMoment))

        if noteGap < 60 {
            return "たった今"
        }

        let minuteCount = noteGap / 60
        if minuteCount < 60 {
            return "\(minuteCount)分前"
        }

        let hourCount = minuteCount / 60
        if hourCount < 24 {
            return "\(hourCount)時間前"
        }

        return "\(hourCount / 24)日前"
    }

    init(pageInk: String, folioThread: String = "guest_thread", pageWhisper: String, lineThread: String, tagEcho: String, echoLinks: [String], noteMoment: TimeInterval = Date().timeIntervalSince1970) {
        self.pageInk = pageInk
        self.folioThread = folioThread
        self.pageWhisper = pageWhisper
        self.lineThread = lineThread
        self.tagEcho = tagEcho
        self.echoLinks = echoLinks
        self.noteMoment = noteMoment
    }
}

extension NotePetal {
    private enum CodingKeys: String, CodingKey {
        case pageInk
        case folioThread
        case pageWhisper
        case lineThread
        case tagEcho
        case echoLinks
        case noteMoment
        case timeWhisper
    }

    init(from decoder: Decoder) throws {
        let pageBox = try decoder.container(keyedBy: CodingKeys.self)
        pageInk = try pageBox.decode(String.self, forKey: .pageInk)
        folioThread = try pageBox.decodeIfPresent(String.self, forKey: .folioThread) ?? "guest_thread"
        pageWhisper = try pageBox.decode(String.self, forKey: .pageWhisper)
        lineThread = try pageBox.decode(String.self, forKey: .lineThread)
        tagEcho = try pageBox.decode(String.self, forKey: .tagEcho)
        echoLinks = try pageBox.decode([String].self, forKey: .echoLinks)

        if let savedMoment = try pageBox.decodeIfPresent(TimeInterval.self, forKey: .noteMoment) {
            noteMoment = savedMoment
        } else {
            let savedTime = try pageBox.decodeIfPresent(String.self, forKey: .timeWhisper)
            noteMoment = Date().timeIntervalSince1970 - NotePetal.ledgerGap(from: savedTime)
        }
    }

    func encode(to encoder: Encoder) throws {
        var pageBox = encoder.container(keyedBy: CodingKeys.self)
        try pageBox.encode(pageInk, forKey: .pageInk)
        try pageBox.encode(folioThread, forKey: .folioThread)
        try pageBox.encode(pageWhisper, forKey: .pageWhisper)
        try pageBox.encode(lineThread, forKey: .lineThread)
        try pageBox.encode(tagEcho, forKey: .tagEcho)
        try pageBox.encode(echoLinks, forKey: .echoLinks)
        try pageBox.encode(noteMoment, forKey: .noteMoment)
    }

    private static func ledgerGap(from timeWhisper: String?) -> TimeInterval {
        guard let timeWhisper else { return 60 }

        if timeWhisper.contains("日前"), let noteCount = Int(timeWhisper.filter(\.isNumber)) {
            return TimeInterval(noteCount * 24 * 60 * 60)
        }

        if timeWhisper.contains("時間前"), let noteCount = Int(timeWhisper.filter(\.isNumber)) {
            return TimeInterval(noteCount * 60 * 60)
        }

        if timeWhisper.contains("分前"), let noteCount = Int(timeWhisper.filter(\.isNumber)) {
            return TimeInterval(noteCount * 60)
        }

        return 60
    }
}

struct WhisperShade: Codable, Equatable {
    let echoInk: String // 人物唯一 id
    var folioThread: String // 所属用户 id
    var aliasEcho: String // 姓名
    var asideThread: String // 备注
    var badgeWhisper: String // 头像资源

    init(echoInk: String, folioThread: String = "guest_thread", aliasEcho: String, asideThread: String, badgeWhisper: String) {
        self.echoInk = echoInk
        self.folioThread = folioThread
        self.aliasEcho = aliasEcho
        self.asideThread = asideThread
        self.badgeWhisper = badgeWhisper
    }
}

extension WhisperShade {
    private enum CodingKeys: String, CodingKey {
        case echoInk
        case folioThread
        case aliasEcho
        case asideThread
        case badgeWhisper
    }

    init(from decoder: Decoder) throws {
        let pageBox = try decoder.container(keyedBy: CodingKeys.self)
        echoInk = try pageBox.decode(String.self, forKey: .echoInk)
        folioThread = try pageBox.decodeIfPresent(String.self, forKey: .folioThread) ?? "guest_thread"
        aliasEcho = try pageBox.decode(String.self, forKey: .aliasEcho)
        asideThread = try pageBox.decode(String.self, forKey: .asideThread)
        badgeWhisper = try pageBox.decode(String.self, forKey: .badgeWhisper)
    }

    func encode(to encoder: Encoder) throws {
        var pageBox = encoder.container(keyedBy: CodingKeys.self)
        try pageBox.encode(echoInk, forKey: .echoInk)
        try pageBox.encode(folioThread, forKey: .folioThread)
        try pageBox.encode(aliasEcho, forKey: .aliasEcho)
        try pageBox.encode(asideThread, forKey: .asideThread)
        try pageBox.encode(badgeWhisper, forKey: .badgeWhisper)
    }
}

final class ThreadWeave {
    static let sharedLedger = ThreadWeave()

    private let threadKey = "ledger_thread_pages"
    private let whisperKey = "ledger_whisper_shades"
    private let threadPin = "ledger_thread_anchor"
    private let whisperPin = "ledger_whisper_anchor"
    private let guestThread = "guest_thread" // 访客数据归属 id
    private let shelfBook: UserDefaults
    private let scriptBook = JSONEncoder()
    private let parseBook = JSONDecoder()
    private var threadGuard = false

    init(shelfBook: UserDefaults = .standard) {
        self.shelfBook = shelfBook
    }

    func weavePrelude() {
        seedLedgerIfNeeded()
    }

    func scopeThread() -> String {
        MurmurArchive.sharedArchive.currentScroll()?.threadInk ?? guestThread
    }

    private func seedLedgerIfNeeded() {
        guard threadGuard == false else {
            return
        }

        threadGuard = true
        defer {
            threadGuard = false
        }

        let folioThread = scopeThread()
        guard folioThread == "1" else {
            return
        }

        let hasThread = threadShelf().contains { $0.folioThread == folioThread }
        let hasWhisper = whisperShelf().contains { $0.folioThread == folioThread }
        guard hasThread == false || hasWhisper == false else {
            return
        }

        let whisperList = [
            WhisperShade(echoInk: "shade_1_\(folioThread)", folioThread: folioThread, aliasEcho: "森川凪", asideThread: "物静かで繊細な心を持つ", badgeWhisper: "ZXICHQWIU1"),
            WhisperShade(echoInk: "shade_2_\(folioThread)", folioThread: folioThread, aliasEcho: "高橋陽菜", asideThread: "明るく周りを元気にする", badgeWhisper: "ZXICHQWIU2"),
            WhisperShade(echoInk: "shade_3_\(folioThread)", folioThread: folioThread, aliasEcho: "藤原颯太", asideThread: "行動力があり頼りになる", badgeWhisper: "ZXICHQWIU3"),
            WhisperShade(echoInk: "shade_4_\(folioThread)", folioThread: folioThread, aliasEcho: "伊東健斗", asideThread: "誠実で真面目な人柄", badgeWhisper: "ZXICHQWIU4")
        ]

        let threadList = [
            NotePetal(pageInk: "petal_1_\(folioThread)", folioThread: folioThread, pageWhisper: "日常の仕事小悩み", lineThread: "毎日の業務で一番大変なこと、楽しい瞬間を教えてください。", tagEcho: "仕事", echoLinks: ["shade_1_\(folioThread)", "shade_2_\(folioThread)"], noteMoment: Date().timeIntervalSince1970 - 60),
            NotePetal(pageInk: "petal_2_\(folioThread)", folioThread: folioThread, pageWhisper: "最近遭遇した珍事件", lineThread: "最近出会った笑える出来事、意外な体験をシェアしましょう。", tagEcho: "趣味", echoLinks: ["shade_2_\(folioThread)", "shade_3_\(folioThread)"], noteMoment: Date().timeIntervalSince1970 - 86_400),
            NotePetal(pageInk: "petal_3_\(folioThread)", folioThread: folioThread, pageWhisper: "行ってみたい憧れの場所", lineThread: "今一番旅に行きたい土地、見てみたい景色はどこですか。", tagEcho: "旅行", echoLinks: ["shade_1_\(folioThread)", "shade_4_\(folioThread)"], noteMoment: Date().timeIntervalSince1970 - 86_400),
            NotePetal(pageInk: "petal_4_\(folioThread)", folioThread: folioThread, pageWhisper: "忘れられない美味しい料理", lineThread: "今まで食べた中で一番美味しかった料理を紹介してください。", tagEcho: "グルメ", echoLinks: ["shade_3_\(folioThread)", "shade_4_\(folioThread)"], noteMoment: Date().timeIntervalSince1970 - 86_400)
        ]

        if hasWhisper == false {
            bindWhispers(whisperList)
        }

        if hasThread == false {
            bindThreads(threadList)
        }
    }

    func threadStack() -> [NotePetal] {
        seedLedgerIfNeeded()
        let folioThread = scopeThread()
        guard folioThread != guestThread else {
            return []
        }

        return threadShelf().filter { $0.folioThread == folioThread }
    }

    func whisperStack() -> [WhisperShade] {
        seedLedgerIfNeeded()
        let folioThread = scopeThread()
        guard folioThread != guestThread else {
            return []
        }

        return whisperShelf().filter { $0.folioThread == folioThread }
    }

    func threadFocus() -> NotePetal? {
        guard let pageInk = shelfBook.string(forKey: threadPinKey()) else {
            return nil
        }

        return threadStack().first { $0.pageInk == pageInk }
    }

    func whisperFocus() -> WhisperShade? {
        guard let echoInk = shelfBook.string(forKey: whisperPinKey()) else {
            return nil
        }

        return whisperStack().first { $0.echoInk == echoInk }
    }

    func threadAnchor(_ pageInk: String?) {
        guard let pageInk else {
            shelfBook.removeObject(forKey: threadPinKey())
            return
        }

        shelfBook.set(pageInk, forKey: threadPinKey())
    }

    func whisperAnchor(_ echoInk: String?) {
        guard let echoInk else {
            shelfBook.removeObject(forKey: whisperPinKey())
            return
        }

        shelfBook.set(echoInk, forKey: whisperPinKey())
    }

    @discardableResult
    func threadFold(pageWhisper: String, lineThread: String, tagEcho: String, echoLinks: [String]) -> NotePetal {
        let pageText = pageWhisper.trimmingCharacters(in: .whitespacesAndNewlines)
        let bodyText = lineThread.trimmingCharacters(in: .whitespacesAndNewlines)

        var threadList = threadStack()
        let pageInk = threadFocus()?.pageInk ?? UUID().uuidString
        let threadPetal = NotePetal(
            pageInk: pageInk,
            folioThread: scopeThread(),
            pageWhisper: pageText.isEmpty ? "入力してください" : pageText,
            lineThread: bodyText.isEmpty ? "入力してください" : bodyText,
            tagEcho: tagEcho,
            echoLinks: echoLinks,
            noteMoment: threadFocus()?.noteMoment ?? Date().timeIntervalSince1970
        )

        if let pageIndex = threadList.firstIndex(where: { $0.pageInk == pageInk }) {
            threadList[pageIndex] = threadPetal
        } else {
            threadList.insert(threadPetal, at: 0)
        }

        writeThreads(threadList)
        threadAnchor(pageInk)
        return threadPetal
    }

    @discardableResult
    func whisperFold(aliasEcho: String, asideThread: String, badgeWhisper: String) -> WhisperShade {
        let nameText = aliasEcho.trimmingCharacters(in: .whitespacesAndNewlines)
        let noteText = asideThread.trimmingCharacters(in: .whitespacesAndNewlines)

        var whisperList = whisperStack()
        let echoInk = whisperFocus()?.echoInk ?? UUID().uuidString
        let whisperShade = WhisperShade(
            echoInk: echoInk,
            folioThread: scopeThread(),
            aliasEcho: nameText.isEmpty ? "入力してください" : nameText,
            asideThread: noteText.isEmpty ? "入力してください" : noteText,
            badgeWhisper: badgeWhisper
        )

        if let whisperIndex = whisperList.firstIndex(where: { $0.echoInk == echoInk }) {
            whisperList[whisperIndex] = whisperShade
        } else {
            whisperList.insert(whisperShade, at: 0)
        }

        writeWhispers(whisperList)
        whisperAnchor(echoInk)
        return whisperShade
    }

    func threadDrop(_ pageInk: String) {
        writeThreads(threadStack().filter { $0.pageInk != pageInk })
        threadAnchor(nil)
    }

    func whisperDrop(_ echoInk: String) {
        writeWhispers(whisperStack().filter { $0.echoInk != echoInk })

        let threadList = threadStack().map { threadPetal in
            var nextThread = threadPetal
            nextThread.echoLinks.removeAll { $0 == echoInk }
            return nextThread
        }
        writeThreads(threadList)
        whisperAnchor(nil)
    }

    func notebookErase() {
        let folioThread = scopeThread()
        let nextThreads = threadShelf().filter { $0.folioThread != folioThread }
        let nextWhispers = whisperShelf().filter { $0.folioThread != folioThread }

        guard let threadData = try? scriptBook.encode(nextThreads),
              let whisperData = try? scriptBook.encode(nextWhispers) else {
            return
        }

        shelfBook.set(threadData, forKey: threadKey)
        shelfBook.set(whisperData, forKey: whisperKey)
        shelfBook.removeObject(forKey: threadPinKey())
        shelfBook.removeObject(forKey: whisperPinKey())
    }

    func echoes(for threadPetal: NotePetal) -> [WhisperShade] {
        let whisperList = whisperStack()
        return threadPetal.echoLinks.compactMap { echoInk in
            whisperList.first { $0.echoInk == echoInk }
        }
    }

    func petals(for whisperShade: WhisperShade) -> [NotePetal] {
        threadStack().filter { $0.echoLinks.contains(whisperShade.echoInk) }
    }

    private func bindThreads(_ seedThreads: [NotePetal]) {
        var threadList = threadStack()

        for threadPetal in seedThreads {
            if let pageIndex = threadList.firstIndex(where: { $0.pageInk == threadPetal.pageInk }) {
                var nextThread = threadPetal
                nextThread.noteMoment = threadList[pageIndex].noteMoment
                threadList[pageIndex] = nextThread
            } else {
                threadList.append(threadPetal)
            }
        }

        writeThreads(threadList)
    }

    private func bindWhispers(_ seedWhispers: [WhisperShade]) {
        var whisperList = whisperStack()

        for whisperShade in seedWhispers {
            if let whisperIndex = whisperList.firstIndex(where: { $0.echoInk == whisperShade.echoInk }) {
                whisperList[whisperIndex] = whisperShade
            } else {
                whisperList.append(whisperShade)
            }
        }

        writeWhispers(whisperList)
    }

    private func writeThreads(_ threadList: [NotePetal]) {
        let folioThread = scopeThread()
        let nextList = threadShelf().filter { $0.folioThread != folioThread } + threadList
        guard let threadData = try? scriptBook.encode(nextList) else {
            return
        }

        shelfBook.set(threadData, forKey: threadKey)
    }

    private func writeWhispers(_ threadList: [WhisperShade]) {
        let folioThread = scopeThread()
        let nextList = whisperShelf().filter { $0.folioThread != folioThread } + threadList
        guard let threadData = try? scriptBook.encode(nextList) else {
            return
        }

        shelfBook.set(threadData, forKey: whisperKey)
    }

    private func threadShelf() -> [NotePetal] {
        guard let threadData = shelfBook.data(forKey: threadKey) else {
            return []
        }

        return (try? parseBook.decode([NotePetal].self, from: threadData)) ?? []
    }

    private func whisperShelf() -> [WhisperShade] {
        guard let threadData = shelfBook.data(forKey: whisperKey) else {
            return []
        }

        return (try? parseBook.decode([WhisperShade].self, from: threadData)) ?? []
    }

    private func threadPinKey() -> String {
        "\(threadPin)_\(scopeThread())"
    }

    private func whisperPinKey() -> String {
        "\(whisperPin)_\(scopeThread())"
    }
}
