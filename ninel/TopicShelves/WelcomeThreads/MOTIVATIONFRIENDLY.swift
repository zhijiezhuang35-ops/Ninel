import SwiftUI

struct MOTIVATIONFRIENDLY: View {
    var cancelThread: () -> Void = {}
    var agreeThread: () -> Void = {}

    var body: some View {
        GeometryReader { topicCanvas in
            ZStack(alignment: .bottom) {
                Color.black.opacity(0.62)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Text("最終利用規約")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 43)

                    Text("""
Ninelへようこそ。より良い場所づくりのため、以下の内容はアプリ内で禁止されています。
1. 子どもの危害やポルノ関連の有害なコンテンツ。
2. 最近または現在の出来事に関する虚偽で有害なメッセージ。
3. あらゆる暴力、いじめに関するコンテンツ、ポルノの公的宣伝その他の有害なコンテンツ。
上記の違反行為を含む（これらに限定されない）コンテンツが見つかった場合、そのコンテンツは削除され、アカウントは禁止処分となります。上記のボタンをクリックすることで、ご利用規約およびプライバシーポリシーに同意したものとみなされます。
""")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white.opacity(0.58))
                    .lineSpacing(5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                    .padding(.horizontal, 30)

                    Spacer().frame(height: 61)

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
                            agreeThread()
                        } label: {
                            Text("同意します")
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
                    .padding(.horizontal, 22)
                    .padding(.bottom, 32)
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 566)
                .padding(.bottom, topicCanvas.safeAreaInsets.bottom)
                .background(
                    LinearGradient(
                        colors: [
                            Color(red: 0.46, green: 0.45, blue: 0.74),
                            Color(red: 0.09, green: 0.09, blue: 0.09)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
