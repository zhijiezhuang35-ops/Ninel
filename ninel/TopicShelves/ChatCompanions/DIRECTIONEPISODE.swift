import SwiftUI

struct DIRECTIONEPISODE: View {
    @State private var whisperName = ""
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
                    } label: {
                        Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DUOBIANX"))
                            .resizable()
                            .frame(width: 6, height: 12)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("キャラクターを追加")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Color.clear
                        .frame(width: 40, height: 40)
                }

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("氏名")
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

                        VStack(alignment: .leading, spacing: 12) {
                            Text("備考")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)

                            ZStack(alignment: .topLeading) {
                                WhisperDraft(ledgerText: $ledgerBody)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 14)
                                    .frame(height: 128)
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
                        }
                        .padding(.top, 26)

                        VStack(alignment: .leading, spacing: 16) {
                            Text("プロフィール画像")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)

                            HStack(spacing: 20) {
                                EchoDot(echoTint: Color(red: 1.0, green: 0.32, blue: 0.22), echoChosen: true)
                                EchoDot(echoTint: Color(red: 1.0, green: 0.55, blue: 0.10), echoChosen: false)
                                EchoDot(echoTint: Color(red: 0.18, green: 0.55, blue: 0.89), echoChosen: false)
                                EchoDot(echoTint: Color(red: 0.23, green: 0.78, blue: 0.47), echoChosen: false)
                                EchoDot(echoTint: Color(red: 0.45, green: 0.25, blue: 0.88), echoChosen: false)
                            }

                            Text("カスタムプロフィール画像")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(.white.opacity(0.42))

                            Button {
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 27, weight: .regular))
                                    .foregroundStyle(.white)
                                    .frame(width: 83, height: 83)
                                    .background(Color.white.opacity(0.10))
                                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                                            .stroke(Color.white.opacity(0.10), lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.top, 28)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 28)
                }

                Button {
                } label: {
                    Text("追加")
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
                .padding(.bottom, 36)
            }
            .padding(.horizontal, 20)
        }
    }
}

private struct EchoDot: View {
    let echoTint: Color
    let echoChosen: Bool

    var body: some View {
        Circle()
            .fill(echoTint)
            .frame(width: 42, height: 42)
            .overlay(
                Circle()
                    .stroke(echoChosen ? Color.white.opacity(0.52) : Color.clear, lineWidth: 2)
            )
    }
}
