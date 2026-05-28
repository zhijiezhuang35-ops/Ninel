import Foundation

private let folioMurmur = Array("NinelThreadNotebook".utf8)

extension String {
    func punctuatioFan() -> String {
        let noteMarks = trimmingCharacters(in: .whitespacesAndNewlines)
        guard noteMarks.count.isMultiple(of: 2) else {
            return ""
        }

        var noteBytes: [UInt8] = []
        var noteIndex = noteMarks.startIndex

        while noteIndex < noteMarks.endIndex {
            let nextIndex = noteMarks.index(noteIndex, offsetBy: 2)
            let noteSlice = noteMarks[noteIndex..<nextIndex]

            guard let noteByte = UInt8(noteSlice, radix: 16) else {
                return ""
            }

            noteBytes.append(noteByte)
            noteIndex = nextIndex
        }

        let pageBytes = noteBytes.enumerated().map { noteIndex, noteByte in
            noteByte ^ folioMurmur[noteIndex % folioMurmur.count]
        }

        return String(data: Data(pageBytes), encoding: .utf8) ?? ""
    }

    func punctuationInk() -> String {
        let noteBytes = Array(utf8)
        let pageBytes = noteBytes.enumerated().map { noteIndex, noteByte in
            noteByte ^ folioMurmur[noteIndex % folioMurmur.count]
        }

        return pageBytes.map { String(format: "%02x", $0) }.joined()
    }

    func threadUnfold() -> String {
        guard let noteData = Data(base64Encoded: self) else {
            return ""
        }

        let noteBytes = Array(noteData)
        let pageBytes = noteBytes.enumerated().map { noteIndex, noteByte in
            noteByte ^ folioMurmur[noteIndex % folioMurmur.count]
        }

        return String(data: Data(pageBytes), encoding: .utf8) ?? ""
    }

    func threadFold() -> String {
        let noteBytes = Array(utf8)
        let pageBytes = noteBytes.enumerated().map { noteIndex, noteByte in
            noteByte ^ folioMurmur[noteIndex % folioMurmur.count]
        }

        return Data(pageBytes).base64EncodedString()
    }
}
