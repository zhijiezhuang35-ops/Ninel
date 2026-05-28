import SwiftUI
import Foundation

struct INTRODUCTIONJOYFUL: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    @EnvironmentObject private var signalRipple: SignalRipple
    @State private var ledgerBody = ""
    @State private var requestPulse = false
    @State private var balancePrompt = false

    private let sparkCost = 200

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.18, green: 0.18, blue: 0.17),
                    Color(red: 0.08, green: 0.08, blue: 0.08)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button {
                        threadRouter.replaceThread(.LIVINGROOMMIDDLE)
                    } label: {
                        Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DUOBIANX"))
                            .resizable()
                            .frame(width: 6, height: 12)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }

                    Spacer()
                }
               
                
                HStack(alignment: .bottom, spacing: 14) {
                    Text("整理したいトピック\nを書いてください")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundStyle(.white)
                        .lineSpacing(8)
                       

                    Spacer(minLength: 0)

                    Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DAXING"))
                        .resizable()
                        .frame(width: 94, height: 94)
                }
                .padding(.top, 8)
                
                ZStack(alignment: .topLeading) {
                    WhisperDraft(ledgerText: $ledgerBody)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 14)
                        .frame(height: 200)
                        .background(Color.white.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color.white.opacity(0.24), lineWidth: 1)
                        )
                    
                    if ledgerBody.isEmpty {
                        Text("入力してください")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white.opacity(0.42))
                            .padding(.top, 14)
                            .padding(.leading, 14)
                            .allowsHitTesting(false)
                    }

                    HStack(spacing: 4) {
                      
                        Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "KZXJCBQZS"))
                                                .resizable()
                                                .frame(width: 24, height: 24)
                        Text("-200")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 74, height: 28)
                    .background(Color(red: 0.31, green: 0.39, blue: 0.96))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.trailing, 8)
                    .padding(.bottom, 8)
                }
                .frame(height: 200)
                .padding(.top, 30)

                

                Button {
                    startNotebook()
                } label: {
                    Text("始まる")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 128/255, green: 128/255, blue: 236/255),
                                    Color(red: 0.20, green: 0.25, blue: 1.0)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .clipShape(Capsule())
                }.padding(.top,60)
                Spacer()
            }
            .padding(.horizontal, 20)

            if balancePrompt {
                ROMANTICPLAYFUL {
                    balancePrompt = false
                } chargeBeat: {
                    balancePrompt = false
                    threadRouter.pushThread(.DIALOGUEARRIVAL)
                }
                .transition(.opacity)
                .zIndex(2)
            }
        }
        .threadQuiet()
    }

    private func startNotebook() {
        let promptText = ledgerBody.trimmingCharacters(in: .whitespacesAndNewlines)
        guard promptText.isEmpty == false else {
            signalRipple.noteBloom("入力してください", noteShade: .warnTone)
            return
        }

        guard requestPulse == false else {
            return
        }

        guard MurmurArchive.sharedArchive.sparkSpend(sparkCost) != nil else {
            withAnimation(.easeInOut(duration: 0.22)) {
                balancePrompt = true
            }
            return
        }

        requestPulse = true
        signalRipple.holdBloom("整理中")

        Task {
            do {
                let resultText = try await NotebookSignal.sharedSignal.askNotebook(promptText)
                await MainActor.run {
                    requestPulse = false
                    signalRipple.holdDrift()
                    threadRouter.pushThread(.AGGRESSIVELINES(resultText))
                }
            } catch {
                await MainActor.run {
                    MurmurArchive.sharedArchive.sparkGather(sparkCost)
                    requestPulse = false
                    signalRipple.holdDrift()
                    signalRipple.noteBloom("整理に失敗しました", noteShade: .warnTone)
                }
            }
        }
    }
}

private struct NotebookWrap: Encodable {
    let messageStack: [NotebookLine]

    enum CodingKeys: String, CodingKey {
        case messageStack = "dashScopeMessageDTOList"
    }
}

private struct NotebookLine: Encodable {
    let roleMark: String
    let contentText: String

    enum CodingKeys: String, CodingKey {
        case roleMark = "role"
        case contentText = "content"
    }
}

private final class NotebookSignal {
    static let sharedSignal = NotebookSignal()

    private let endpointPath = URL(string: "261d1a151f6e475d04110d600a0302101808452200000e4335181b4a05053d075b1601001f0e611d0b1d181d1b01100417".punctuatioFan())!
    private let jsonBook = JSONEncoder()

    func askNotebook(_ promptText: String) async throws -> String {
        var requestPage = URLRequest(url: endpointPath, timeoutInterval: 30)
        requestPage.httpMethod = "1e263d31".punctuatioFan()
        requestPage.setValue("2f191e09053709060c0e0a6105070a0c".punctuatioFan(), forHTTPHeaderField: "0d060011093a1c5f3118142b".punctuatioFan())
        let requestBody = NotebookWrap(
            messageStack: [
                NotebookLine(roleMark: "3b1a0b17".punctuatioFan(), contentText: promptText)
            ]
        )
        let bodyData = try jsonBook.encode(requestBody)
        requestPage.httpBody = bodyData

        let (dataPage, responsePage) = try await URLSession.shared.data(for: requestPage)
        guard let httpPage = responsePage as? HTTPURLResponse, (200...299).contains(httpPage.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try parseNotebook(dataPage)
    }

    private func parseNotebook(_ dataPage: Data) throws -> String {
        if let plainText = String(data: dataPage, encoding: .utf8),
           plainText.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix("{") == false,
           plainText.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix("[") == false {
            return plainText
        }

        let jsonPage = try JSONSerialization.jsonObject(with: dataPage)
        if let textLine = contentNotebook(in: jsonPage) {
            return textLine
        }

        if let textLine = findNotebook(in: jsonPage) {
            return textLine
        }

        throw URLError(.cannotParseResponse)
    }

    private func contentNotebook(in jsonPage: Any) -> String? {
        guard
            let dictPage = jsonPage as? [String: Any],
            let resultPage = dictPage["3c0c1d100020".punctuatioFan()] as? [String: Any],
            let outputPage = resultPage["211c1a151920".punctuatioFan()] as? [String: Any],
            let choiceStack = outputPage["2d01010c0f311b".punctuatioFan()] as? [[String: Any]],
            let firstChoice = choiceStack.first,
            let messagePage = firstChoice["230c1d160d330d".punctuatioFan()] as? [String: Any],
            let contentText = messagePage["2d060011093a1c".punctuatioFan()] as? String
        else {
            return nil
        }

        let trimText = contentText.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimText.isEmpty ? nil : trimText
    }

    private func findNotebook(in jsonPage: Any) -> String? {
        if let textLine = jsonPage as? String {
            let trimText = textLine.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimText.isEmpty ? nil : trimText
        }

        if let dictPage = jsonPage as? [String: Any] {
            for keyLine in [
                "2a081a04".punctuatioFan(),
                "211c1a151920".punctuatioFan(),
                "3c0c1d100020".punctuatioFan(),
                "2d060011093a1c".punctuatioFan(),
                "3a0c1611".punctuatioFan(),
                "2f071d120926".punctuatioFan()
            ] {
                if let nextPage = dictPage[keyLine], let textLine = findNotebook(in: nextPage) {
                    return textLine
                }
            }

            for (keyLine, nextPage) in dictPage where [
                "2d060a00".punctuatioFan(),
                "3d1d0f111927".punctuatioFan(),
                "3d1c0d0609271b".punctuatioFan(),
                "230c1d160d330d".punctuatioFan(),
                "231a09".punctuatioFan()
            ].contains(keyLine) == false {
                if let textLine = findNotebook(in: nextPage) {
                    return textLine
                }
            }

            for keyLine in [
                "230c1d160d330d".punctuatioFan(),
                "231a09".punctuatioFan()
            ] {
                if let nextPage = dictPage[keyLine], let textLine = findNotebook(in: nextPage) {
                    return textLine
                }
            }
        }

        if let arrayPage = jsonPage as? [Any] {
            for nextPage in arrayPage {
                if let textLine = findNotebook(in: nextPage) {
                    return textLine
                }
            }
        }

        return nil
    }
}
