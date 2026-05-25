import SwiftUI

struct AGGRESSIVELINES: View {
    private let ledgerBody = """
事前にルートを計画しましょう。ハイキングを始める前に、コースの詳細を調べ、難易度や距離、予想される天候を確認してください。無線通信がない場合は、地図をダウンロードするか、紙の地図を持参しましょう。
2. 正しい装備を着用する
快適で、慣れてきたハイキングブーツや靴を選ぶ。温度の変化に合わせて調節できるよう、重ね着をして服装を整え、湿気を吸収する衣類を着ることで乾燥を保つ。
3. 必要品を準備する
常に十分な水、おやつ、救急キット、日焼け止め、懐中電灯またはヘッドランプ、マルチツールやナイフ、緊急用ホイッスルを持参しましょう。レインジャケットやポンチョも便利です。
"""

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
                }

                HStack(alignment: .bottom, spacing: 14) {
                    Text("AIアシスタント\n整理結果")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundStyle(.white)
                        .lineSpacing(8)

                    Spacer(minLength: 0)

                    Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DAXING"))
                        .resizable()
                        .frame(width: 94, height: 94)
                }
                .padding(.top, 8)

                ScrollView(showsIndicators: false) {
                    Text(ledgerBody)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white.opacity(0.88))
                        .lineSpacing(4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 30)
                        .padding(.bottom, 24)
                }

                Spacer(minLength: 0)

                Button {
                } label: {
                    Text("コピー")
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
            .padding(.horizontal, 20)
        }
    }
}
