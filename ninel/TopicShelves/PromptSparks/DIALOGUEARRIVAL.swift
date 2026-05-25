import SwiftUI

struct DIALOGUEARRIVAL: View {
    private let memoPairs = [
        ("400", "$ 0.99"),
        ("800", "$ 1.99"),
        ("1780", "$ 3.99"),
        ("2450", "$ 4.99"),
        ("5110", "$ 9.99"),
        ("10800", "$ 19.99"),
        ("14900", "$ 29.99"),
        ("29400", "$ 49.99"),
        ("34500", "$ 69.99"),
        ("63700", "$ 99.99")
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
                    } label: {
                        Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DUOBIANX"))
                            .resizable()
                            .frame(width: 6, height: 12)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("チャージ")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Color.clear
                        .frame(width: 40, height: 40)
                }
                
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
                .padding(.top, 24)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 15),
                            GridItem(.flexible(), spacing: 15)
                        ],
                        spacing: 18
                    ) {
                        ForEach(memoPairs, id: \.0) { echoPair in
                            NoteOffer(ledgerAmount: echoPair.0, whisperPrice: echoPair.1)
                        }
                    }
                    .padding(.top, 20)
                }
            }
            .padding(.horizontal, 14)
        }
    }
}

private struct NoteOffer: View {
    let ledgerAmount: String
    let whisperPrice: String

    var body: some View {
        Button {
        } label: {
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "KZXJCBQZS"))
                        .resizable()
                        .frame(width: 40, height: 40)

                    Text(ledgerAmount)
                        .font(.system(size: 18, weight: .black))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                }
                .padding(.top, 10)

                Text(whisperPrice)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                    .frame(width: 100, height: 28)
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
                    .padding(.top, 6)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 90)
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
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
        }
    }
}
