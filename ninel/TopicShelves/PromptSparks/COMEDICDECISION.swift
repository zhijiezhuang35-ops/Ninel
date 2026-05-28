import SwiftUI

struct COMEDICDECISION: View {
    let cancelThread: () -> Void
    let confirmThread: () -> Void

    @State private var slideLetter = false

    var body: some View {
        ZStack {
            Color.black.opacity(slideLetter ? 0.42 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    foldLedger(cancelThread)
                }

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 0) {
                    Text("アカウントを削除")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 43)

                    Text("本当にアカウントを削除する意思がありますか?")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.white.opacity(0.60))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 42)
                        .padding(.top, 16)

                    HStack(spacing: 15) {
                        Button {
                            foldLedger(cancelThread)
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
                            foldLedger(confirmThread)
                        } label: {
                            Text("確認")
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
                    .padding(.horizontal, 28)
                    .padding(.top, 24)
                    .padding(.bottom, 36)
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [
                            Color(red: 0.29, green: 0.28, blue: 0.43),
                            Color(red: 0.10, green: 0.10, blue: 0.10)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .offset(y: slideLetter ? 0 : 360)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .animation(.spring(response: 0.34, dampingFraction: 0.88), value: slideLetter)
        .onAppear {
            DispatchQueue.main.async {
                slideLetter = true
            }
        }
    }

    private func foldLedger(_ threadBeat: @escaping () -> Void) {
        withAnimation(.spring(response: 0.28, dampingFraction: 0.92)) {
            slideLetter = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            threadBeat()
        }
    }
}
