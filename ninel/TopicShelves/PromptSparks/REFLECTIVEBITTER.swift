import SwiftUI

struct REFLECTIVEBITTER: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    @EnvironmentObject private var signalRipple: SignalRipple

    @State private var ledgerBody = ""

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

                    Text("フィードバック")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Color.clear
                        .frame(width: 40, height: 40)
                }

                ZStack(alignment: .topLeading) {
                    WhisperDraft(ledgerText: $ledgerBody)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 14)
                        .frame(height: 280)
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
                }
                .frame(height: 280)
                .padding(.top, 32)

                Button {
                    guard ledgerBody.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
                        signalRipple.noteBloom("入力してください", noteShade: .warnTone)
                        return
                    }

                    signalRipple.holdEcho("送信中") {
                        signalRipple.noteBloom("フィードバックを送信しました")
                        threadRouter.popThread()
                    }
                } label: {
                    Text("提出")
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
                .padding(.top, 60)

                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .threadQuiet()
    }
}
