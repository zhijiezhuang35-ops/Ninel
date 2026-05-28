import SwiftUI
import UIKit

struct AGGRESSIVELINES: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    @EnvironmentObject private var signalRipple: SignalRipple
    let ledgerBody: String

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
                        threadRouter.replaceThread(.LIVINGROOMMIDDLE)
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
                    UIPasteboard.general.string = ledgerBody
                    signalRipple.noteBloom("コピーしました")
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
