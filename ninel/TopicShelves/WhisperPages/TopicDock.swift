import SwiftUI

struct TopicDock: View {
    let currentThread: ThreadRoute
    var gateThread: () -> Void = {}

    var body: some View {
        HStack(spacing: 0) {
            DockNote(noteFile: "OZXCNIWND1", whisperLabel: "話題", currentThread: currentThread, targetThread: .LIVINGROOMMIDDLE, gateThread: gateThread)
            Spacer()
            DockNote(noteFile: "OZXCNIWND2", whisperLabel: "人物", currentThread: currentThread, targetThread: .DRAMATICEXCITED, gateThread: gateThread)
            Spacer()
            DockNote(noteFile: "OZXCNIWND3", whisperLabel: "設定", currentThread: currentThread, targetThread: .ANSWERDISCUSS, gateThread: gateThread)
        }
        .padding(.horizontal, 46)
        .frame(height: 82)
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
}

private struct DockNote: View {
    @EnvironmentObject private var threadRouter: ThreadRouter

    let noteFile: String
    let whisperLabel: String
    let currentThread: ThreadRoute
    let targetThread: ThreadRoute
    var gateThread: () -> Void

    private var echoChosen: Bool {
        currentThread == targetThread
    }

    var body: some View {
        Button {
            guard echoChosen == false else { return }
            guard MurmurArchive.sharedArchive.guestLedger() == false || targetThread == .LIVINGROOMMIDDLE else {
                gateThread()
                return
            }
            threadRouter.replaceThread(targetThread)
        } label: {
            VStack(spacing: 4) {
                Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "\(noteFile)\(echoChosen ? "L" : "H")"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)

                Text(whisperLabel)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(echoChosen ? .white : .white.opacity(0.42))
            }
            .frame(width: 50)
        }
    }
}

struct NotebookGate: View {
    var cancelThread: () -> Void = {}
    var loginThread: () -> Void = {}

    var body: some View {
        ZStack {
            Color.black.opacity(0.54)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 0) {
                    Text("ログインが必要です")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 43)

                    Text("この機能を利用するには、ログインしてください。")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 42)
                        .padding(.top, 16)

                    HStack(spacing: 15) {
                        Button {
                            cancelThread()
                        } label: {
                            Text("キャンセル")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white.opacity(0.70))
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color.white.opacity(0.11))
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(Color.white.opacity(0.18), lineWidth: 1)
                                )
                        }

                        Button {
                            loginThread()
                        } label: {
                            Text("ログイン")
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
                    .padding(.horizontal, 28)
                    .padding(.top, 24)
                    .padding(.bottom, 38)
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [
                            Color(red: 0.29, green: 0.28, blue: 0.43),
                            Color(red: 0.10, green: 0.10, blue: 0.10)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}
