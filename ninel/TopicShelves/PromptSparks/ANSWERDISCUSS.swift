import SwiftUI

struct ANSWERDISCUSS: View {
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

            VStack(alignment: .leading, spacing: 0) {
                Text("設定")
                    .font(.system(size: 30, weight: .black))
                    .foregroundStyle(.white)
                    

                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("残高")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white.opacity(0.54))

                        Text("400")
                            .font(.system(size: 18, weight: .black))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "KZXJCBQZS"))
                        .resizable()
                        .frame(width: 72, height: 72)
                        .padding(.trailing, 20)
                }
                .padding(.leading, 14)
                .frame(height: 72)
                .frame(maxWidth: .infinity)
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
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.top,32)
                

                VStack(spacing: 0) {
                    NoteLink(whisperLabel: "プライバシーポリシー", echoWarn: false)
                    NoteLink(whisperLabel: "利用規約", echoWarn: false)
                    NoteLink(whisperLabel: "フィードバック", echoWarn: false)
                }
                .padding(.vertical, 8)
                .background(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.14),
                            Color.white.opacity(0.08)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.white.opacity(0.14), lineWidth: 1)
                )
                .padding(.top, 20)

                VStack(spacing: 0) {
                    NoteLink(whisperLabel: "アカウントを削除", echoWarn: true)
                    NoteLink(whisperLabel: "アカウントを終了", echoWarn: false)
                }
                .padding(.vertical, 8)
                .background(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.14),
                            Color.white.opacity(0.08)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.white.opacity(0.14), lineWidth: 1)
                )
                .padding(.top, 20)

                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}

private struct NoteLink: View {
    let whisperLabel: String
    let echoWarn: Bool

    var body: some View {
        Button {
        } label: {
            HStack(spacing: 12) {
                Text(whisperLabel)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(echoWarn ? Color(red: 1.0, green: 0.22, blue: 0.12) : .white)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white.opacity(0.82))
                    .frame(width: 24, height: 24)
                    .background(Color.white.opacity(0.16))
                    .clipShape(Circle())
            }
            .padding(.horizontal, 14)
            .frame(height: 45)
        }
    }
}
