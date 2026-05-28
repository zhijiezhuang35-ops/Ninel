import Foundation

struct LetterScroll: Codable, Equatable {
    let threadInk: String // 用户唯一 id
    var letterPath: String // 邮箱
    var phraseSeal: String // 密码
    var sparkTally: Int // 钻石数量

    init(
        threadInk: String = UUID().uuidString,
        letterPath: String,
        phraseSeal: String,
        sparkTally: Int = 400
    ) {
        self.threadInk = threadInk
        self.letterPath = letterPath
        self.phraseSeal = phraseSeal
        self.sparkTally = sparkTally
    }
}

final class MurmurArchive {
    static let sharedArchive = MurmurArchive()
    
    private let ledgerMark = "thread_folio_stack"
    private let preludeMark = "thread_folio_prelude"
    private let anchorMark = "thread_folio_anchor"
    private let guestMark = "thread_folio_guest"
    private let shelfBook: UserDefaults
    private let scriptBook = JSONEncoder()
    private let parseBook = JSONDecoder()
    
    init(shelfBook: UserDefaults = .standard) {
        self.shelfBook = shelfBook
    }
    
    private func whisperStack() -> [LetterScroll] {
        guard let threadData = shelfBook.data(forKey: ledgerMark) else {
            return []
        }
        
        return (try? parseBook.decode([LetterScroll].self, from: threadData)) ?? []
    }
    
    func preludePage() {
        guard shelfBook.bool(forKey: preludeMark) == false, whisperStack().isEmpty else {
            return
        }
        
        let whisperList = [
            LetterScroll(
                threadInk: "1",
                letterPath: "demo@gmail.com",
                phraseSeal: "123456",
                sparkTally:0
            ),
        ]
        
        archiveBind(whisperList)
        shelfBook.set(true, forKey: preludeMark)
    }

    func pathLetter(_ letterPath: String) -> LetterScroll? {
        let pagePath = letterPath.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return whisperStack().first { $0.letterPath.lowercased() == pagePath }
    }

    func sealPhrase(letterPath: String, phraseSeal: String) -> LetterScroll? {
        guard let scrollNote = pathLetter(letterPath) else {
            return nil
        }
        return scrollNote.phraseSeal == phraseSeal ? scrollNote : nil
    }

    func foldLetter(letterPath: String, phraseSeal: String) -> LetterScroll? {
        let pagePath = letterPath.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let sealLine = phraseSeal.trimmingCharacters(in: .whitespacesAndNewlines)

        guard pagePath.isEmpty == false, sealLine.isEmpty == false, pathLetter(pagePath) == nil else {
            return nil
        }

        var scrollStack = whisperStack()
        let scrollNote = LetterScroll(letterPath: pagePath, phraseSeal: sealLine)
        scrollStack.append(scrollNote)
        archiveBind(scrollStack)
        return scrollNote
    }

    func markThread(_ scrollNote: LetterScroll) {
        shelfBook.set(false, forKey: guestMark)
        shelfBook.set(scrollNote.threadInk, forKey: anchorMark)
    }

    func guestPage() {
        shelfBook.set(true, forKey: guestMark)
        shelfBook.removeObject(forKey: anchorMark)
    }

    func guestLedger() -> Bool {
        shelfBook.bool(forKey: guestMark)
    }

    func currentScroll() -> LetterScroll? {
        guard let threadInk = shelfBook.string(forKey: anchorMark) else {
            return nil
        }

        return whisperStack().first { $0.threadInk == threadInk }
    }

    func driftPage() {
        shelfBook.set(false, forKey: guestMark)
        shelfBook.removeObject(forKey: anchorMark)
    }

    func eraseArchive() {
        guard let threadInk = shelfBook.string(forKey: anchorMark) else {
            return
        }

        let scrollStack = whisperStack().filter { $0.threadInk != threadInk }
        archiveBind(scrollStack)
        shelfBook.set(false, forKey: guestMark)
        shelfBook.removeObject(forKey: anchorMark)
    }

    @discardableResult
    func sparkGather(_ sparkCount: Int) -> LetterScroll? {
        guard let threadInk = shelfBook.string(forKey: anchorMark) else {
            return nil
        }

        var scrollStack = whisperStack()
        guard let noteIndex = scrollStack.firstIndex(where: { $0.threadInk == threadInk }) else {
            return nil
        }

        scrollStack[noteIndex].sparkTally += sparkCount
        archiveBind(scrollStack)
        return scrollStack[noteIndex]
    }

    @discardableResult
    func sparkSpend(_ sparkCount: Int) -> LetterScroll? {
        guard let threadInk = shelfBook.string(forKey: anchorMark) else {
            return nil
        }

        var scrollStack = whisperStack()
        guard let noteIndex = scrollStack.firstIndex(where: { $0.threadInk == threadInk }) else {
            return nil
        }

        guard scrollStack[noteIndex].sparkTally >= sparkCount else {
            return nil
        }

        scrollStack[noteIndex].sparkTally -= sparkCount
        archiveBind(scrollStack)
        return scrollStack[noteIndex]
    }

    private func archiveBind(_ whisperList: [LetterScroll]) {
        guard let threadData = try? scriptBook.encode(whisperList) else {
            return
        }

        shelfBook.set(threadData, forKey: ledgerMark)
    }
}
