import SwiftUI

struct EMOTIONALGESTURE: View {
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
                    Text("新プロジェクトの計画")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)

                    Text("入力してください")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white.opacity(0.86))
                        .padding(.top, 14)

                    Text("関連人物")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 26)

                    VoiceRibbon(whisperName: "さいとう りょうた", echoMinus: false)
                        .padding(.top, 12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,32)
                

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
