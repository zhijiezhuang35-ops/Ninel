import SwiftUI

struct INTRODUCTIONJOYFUL: View {
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
                }
               
                
                HStack(alignment: .bottom, spacing: 14) {
                    Text("整理したいトピック\nを書いてください")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundStyle(.white)
                        .lineSpacing(8)
                       

                    Spacer(minLength: 0)

                    Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DAXING"))
                        .resizable()
                        .frame(width: 94, height: 94)
                }
                .padding(.top, 8)
                
                ZStack(alignment: .topLeading) {
                    WhisperDraft(ledgerText: $ledgerBody)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 14)
                        .frame(height: 200)
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

                    HStack(spacing: 4) {
                      
                        Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "KZXJCBQZS"))
                                                .resizable()
                                                .frame(width: 24, height: 24)
                        Text("-200")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 74, height: 28)
                    .background(Color(red: 0.31, green: 0.39, blue: 0.96))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.trailing, 8)
                    .padding(.bottom, 8)
                }
                .frame(height: 200)
                .padding(.top, 30)

                Spacer()

                Button {
                } label: {
                    Text("始まる")
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
