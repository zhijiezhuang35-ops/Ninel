import SwiftUI

struct DISCOVERYTWIST: View {
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

                    Button {
                    } label: {
                        Text("編集")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(Color(red: 0.30, green: 0.38, blue: 1.0))
                    }
                }

                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.82))
                                .frame(width: 76, height: 76)

                            Image(systemName: "person.fill")
                                .font(.system(size: 38, weight: .semibold))
                                .foregroundStyle(Color.black.opacity(0.30))
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text("さいとう りょうた")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)

                            Text("入力してください")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.white.opacity(0.66))
                        }
                        Spacer()
                    }

                    Text("関連トピック")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 24)

                    ThreadPanel(pageLine: "新プロジェクトの計画", voiceCount: "3人", traceHour: "1分前", memoMark: "#仕事")
                        .padding(.top, 12)

                    Button {
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 26, weight: .regular))
                            .foregroundStyle(.white.opacity(0.62))
                            .frame(maxWidth: .infinity)
                            .frame(height: 96)
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
                    .padding(.top, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 32)

                Spacer()

                Button {
                } label: {
                    Text("削除")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 1.0, green: 0.33, blue: 0.23),
                                    Color(red: 1.0, green: 0.14, blue: 0.04)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .clipShape(Capsule())
                }
                
            }
            .padding(.horizontal, 20)
        }
    }
}

private struct ThreadPanel: View {
    let pageLine: String
    let voiceCount: String
    let traceHour: String
    let memoMark: String

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
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
        .frame(height: 96)
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
