import SwiftUI

struct LIVINGROOMMIDDLE: View {
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
                HStack(alignment: .center) {
                    ZStack(alignment: .leading) {
                        Text("Ninel")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundStyle(Color(red: 0.23, green: 0.27, blue: 1.0))
                            .offset(x: -3, y: 2)

                        Text("Ninel")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    Button {
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundStyle(.white)
                            .frame(width: 38, height: 38)
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
                
                .padding(.horizontal, 14)

                Button {
                } label: {
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("AIアシスタント")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)

                            Text("トピックを素早く整理するお手伝いを")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.white.opacity(0.52))

                            Spacer(minLength: 0)

                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(Color.white.opacity(0.18))
                                .clipShape(Circle())
                        }

                        Spacer()
                        Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DAXING"))
                                                .resizable()
                                                .frame(width: 94, height: 94)
                                                .padding(.trailing,16)
                    }
                    .padding(.leading, 14)
                    .padding(.vertical, 15)
                    .frame(height: 126)
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
                }
                .padding(.top, 16)
                .padding(.horizontal, 14)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        MurmurToken(whisperLabel: "すべて", memoGlyph: "", echoChosen: true)
                        MurmurToken(whisperLabel: "仕事", memoGlyph: "💼", echoChosen: false)
                        MurmurToken(whisperLabel: "趣味", memoGlyph: "🎨", echoChosen: false)
                        MurmurToken(whisperLabel: "旅行", memoGlyph: "✈️", echoChosen: false)
                    }
                    .padding(.horizontal, 14)
                }
                .padding(.top, 20)

                VStack(spacing: 20) {
                    LedgerPane(pageLine: "新プロジェクトの計画", voiceCount: "2人", traceHour: "1分前", memoMark: "#仕事")
                    LedgerPane(pageLine: "次四半期の目標", voiceCount: "1人", traceHour: "1日前", memoMark: "#仕事")
                    LedgerPane(pageLine: "チームビルディングイベントの案", voiceCount: "3人", traceHour: "1日前", memoMark: "#仕事")
                }
                .padding(.top, 20)
                .padding(.horizontal, 14)

                Spacer(minLength: 92)
            }
            

        }
    }
}

private struct LedgerPane: View {
    let pageLine: String
    let voiceCount: String
    let traceHour: String
    let memoMark: String

    var body: some View {
        HStack(alignment: .bottom,spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text(pageLine)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                HStack(spacing: 5) {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white.opacity(0.58))

                    Text(voiceCount)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white.opacity(0.58))

                    Text(traceHour)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white.opacity(0.58))
                }

                Text(memoMark)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.white.opacity(0.52))
                    .padding(.horizontal, 10)
                    .frame(height: 24)
                    .background(Color.white.opacity(0.08))
                    .clipShape(Capsule())
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
        .frame(height: 106)
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
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.white.opacity(0.14), lineWidth: 1)
        )
    }
}

private struct AnchorMark: View {
    let memoGlyph: String
    let whisperLabel: String
    let echoChosen: Bool

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: memoGlyph)
                .font(.system(size: 23, weight: .bold))
                .foregroundStyle(echoChosen ? .black : .white.opacity(0.42))
                .frame(width: 26, height: 26)
                .background(echoChosen ? Color.white : Color.clear)
                .clipShape(Circle())

            Text(whisperLabel)
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(echoChosen ? .white : .white.opacity(0.42))
        }
        .frame(width: 50)
    }
}
