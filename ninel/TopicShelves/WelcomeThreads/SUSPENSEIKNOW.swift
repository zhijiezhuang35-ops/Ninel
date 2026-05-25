import SwiftUI

struct SUSPENSEIKNOW: View {
    @State private var dialogMail = ""
    @State private var notebookKey = ""
    @State private var threadKey = ""

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.18, green: 0.18, blue: 0.17),
                    Color(red: 0.09, green: 0.09, blue: 0.09)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .overlay(alignment: .topTrailing) {
                Circle()
                    .fill(Color(red: 0.35, green: 0.38, blue: 1.0).opacity(0.11))
                    .frame(width: 210, height: 210)
                    .blur(radius: 62)
                    .offset(x: 84, y: 52)
            }
            .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button {
                    } label: {
                        Image(uiImage: threadEcho(topicFolder: "SuggestorTense", noteFile: "DUOBIANX"))
                            .resizable()
                            .frame(width: 6, height: 12)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("パスワードを忘れた")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Color.clear
                        .frame(width: 40, height: 40)
                }

                VStack(alignment: .leading, spacing: 17) {
                    VStack(alignment: .leading, spacing: 9) {
                        Text("メール")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)

                        TextField("", text: $dialogMail, prompt: Text("メールアドレスを入力してください").foregroundColor(.white.opacity(0.42)))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding(.horizontal, 14)
                            .frame(height: 48)
                            .background(Color.white.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(Color.white.opacity(0.24), lineWidth: 1)
                            )
                    }

                    VStack(alignment: .leading, spacing: 9) {
                        Text("パスワード")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)

                        SecureField("", text: $notebookKey, prompt: Text("パスワードを入力してください").foregroundColor(.white.opacity(0.42)))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .frame(height: 48)
                            .background(Color.white.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(Color.white.opacity(0.24), lineWidth: 1)
                            )
                    }

                    SecureField("", text: $threadKey, prompt: Text("パスワードを入力してください").foregroundColor(.white.opacity(0.42)))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 14)
                        .frame(height: 48)
                        .background(Color.white.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color.white.opacity(0.24), lineWidth: 1)
                        )
                        .padding(.top, -2)
                }
                .padding(.top, 60)

                Button {
                } label: {
                    Text("次のステップ")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
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
                .padding(.top, 120)
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.horizontal, 13)
        }
    }
}
