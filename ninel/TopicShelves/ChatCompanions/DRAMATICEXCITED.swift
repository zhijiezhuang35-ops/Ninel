import SwiftUI

struct DRAMATICEXCITED: View {
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
                HStack(alignment: .center) {
                    Text("メンバー")
                        .font(.system(size: 30, weight: .black))
                        .foregroundStyle(.white)

                    Spacer()

                    Button {
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 25, weight: .regular))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
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
                            .clipShape(Circle())
                    }
                }
                

                VStack(spacing: 16) {
                    VoiceTile(whisperName: "さいとう りょうた", ledgerCount: "1つのトピック", memoFace: "gray", echoTint: Color.white.opacity(0.82))
                    VoiceTile(whisperName: "さくらい みさき", ledgerCount: "3つのトピック", memoFace: "blue", echoTint: Color(red: 0.15, green: 0.52, blue: 0.66))
                    VoiceTile(whisperName: "すずき れん", ledgerCount: "0つのトピック", memoFace: "sap", echoTint: Color.white.opacity(0.90))
                    VoiceTile(whisperName: "すずき れん", ledgerCount: "0つのトピック", memoFace: "す", echoTint: Color(red: 1.0, green: 0.30, blue: 0.18))
                    VoiceTile(whisperName: "さくらい みさき", ledgerCount: "3つのトピック", memoFace: "さ", echoTint: Color(red: 0.46, green: 0.24, blue: 0.92))
                }
                .padding(.top, 28)

                Spacer()
            }
            .padding(.horizontal, 14)
        }
    }
}

private struct VoiceTile: View {
    let whisperName: String
    let ledgerCount: String
    let memoFace: String
    let echoTint: Color

    var body: some View {
        Button {
        } label: {
            HStack(spacing: 12) {
                Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "ICON"))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 44, height: 44)
                                        .clipShape(Circle())

                VStack(alignment: .leading, spacing: 6) {
                    Text(whisperName)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(1)

                    HStack(spacing: 5) {
                        Image(systemName: "number.circle.fill")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white.opacity(0.58))

                        Text(ledgerCount)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white.opacity(0.50))
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white.opacity(0.82))
                    .frame(width: 24, height: 24)
                    .background(Color.white.opacity(0.16))
                    .clipShape(Circle())
            }
            .padding(.horizontal, 16)
            .frame(height: 68)
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
        }
    }
}
