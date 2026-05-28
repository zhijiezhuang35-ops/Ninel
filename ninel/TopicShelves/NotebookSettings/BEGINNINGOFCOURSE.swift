import SwiftUI

struct BEGINNINGOFCOURSE: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    @EnvironmentObject private var signalRipple: SignalRipple
    @State private var whisperName = ""
    @State private var ledgerBody = ""
    @State private var tagEcho = "仕事"
    @State private var echoLinks: [String] = []
    @State private var didLoad = false
    @State private var planShown = false

    private let markStack = [
        ("仕事", "💼"),
        ("趣味", "🎨"),
        ("旅行", "✈️"),
        ("グルメ", "🍜")
    ]

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
                        threadRouter.popThread()
                    } label: {
                        Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DUOBIANX"))
                            .resizable()
                            .frame(width: 6, height: 12)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("新しい項目を追加する")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Color.clear
                        .frame(width: 40, height: 40)
                }

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("プロジェクトの分類")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(markStack, id: \.0) { threadPair in
                                        Button {
                                            tagEcho = threadPair.0
                                        } label: {
                                            MurmurToken(whisperLabel: threadPair.0, glyphEcho: threadPair.1, echoChosen: tagEcho == threadPair.0)
                                        }
                                    }
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 9) {
                            Text("タイトル")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)

                            TextField("", text: $whisperName, prompt: Text("入力してください").foregroundColor(.white.opacity(0.42)))
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 14)
                                .frame(height: 48)
                                .background(Color.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .stroke(Color.white.opacity(0.24), lineWidth: 1)
                                )
                        }
                        .padding(.top, 22)

                        VStack(alignment: .leading, spacing: 9) {
                            Text("プロジェクト内容")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)

                            ZStack(alignment: .topLeading) {
                                WhisperDraft(ledgerText: $ledgerBody)
                                    .padding(.horizontal, 9)
                                    .padding(.vertical, 8)
                                    .frame(height: 112)
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
                                        .padding(.top, 8)
                                        .padding(.leading, 9)
                                        .allowsHitTesting(false)
                                }
                            }
                        }
                        .padding(.top, 22)

                        VStack(alignment: .leading, spacing: 9) {
                            Text("関連人物")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)

                            ForEach(ThreadWeave.sharedLedger.whisperStack().filter { echoLinks.contains($0.echoInk) }, id: \.echoInk) { whisperShade in
                                Button {
                                    echoLinks.removeAll { $0 == whisperShade.echoInk }
                                } label: {
                                    WhisperRibbon(whisperName: whisperShade.aliasEcho, badgeWhisper: whisperShade.badgeWhisper, echoMinus: true)
                                }
                            }

                            Button {
                                withAnimation(.easeOut(duration: 0.12)) {
                                    planShown = true
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 22, weight: .regular))
                                    .foregroundStyle(.white.opacity(0.76))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                                    .background(Color.white.opacity(0.12))
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .stroke(Color.white.opacity(0.24), lineWidth: 1)
                                    )
                            }
                            .padding(.top, 4)
                        }
                        .padding(.top, 22)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 24)
                    
                    Button {
                        saveNotePetal()
                    } label: {
                        Text(ThreadWeave.sharedLedger.threadFocus() == nil ? "プロジェクトを作成する" : "保存")
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
                    }
                }

            
            }
            .padding(.horizontal, 20)
           
            if planShown {
                MONOLOGUEPLAN(threadLinks: $echoLinks) {
                    planShown = false
                }
            }
        }
        .threadQuiet()
        .onAppear {
            loadNotePetal()
        }
    }

    private func loadNotePetal() {
        guard didLoad == false else { return }
        didLoad = true

        guard let threadPetal = ThreadWeave.sharedLedger.threadFocus() else {
            echoLinks = []
            return
        }

        whisperName = threadPetal.pageWhisper
        ledgerBody = threadPetal.lineThread
        tagEcho = threadPetal.tagEcho
        echoLinks = threadPetal.echoLinks
    }

    private func saveNotePetal() {
        guard whisperName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false,
              ledgerBody.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            signalRipple.noteBloom("入力してください", noteShade: .warnTone)
            return
        }

        signalRipple.holdEcho(ThreadWeave.sharedLedger.threadFocus() == nil ? "作成中" : "保存中") {
            ThreadWeave.sharedLedger.threadFold(pageWhisper: whisperName, lineThread: ledgerBody, tagEcho: tagEcho, echoLinks: echoLinks)
            threadRouter.replaceThread(.LIVINGROOMMIDDLE)
        }
    }
}
