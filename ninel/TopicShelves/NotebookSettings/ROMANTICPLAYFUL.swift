import SwiftUI

struct ROMANTICPLAYFUL: View {
    var cancelBeat: () -> Void = {}
    var chargeBeat: () -> Void = {}

    var body: some View {
        ZStack {
            Color.black.opacity(0.54)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 0) {
                    Text("残高が不足しています")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 43)

                    Text("残高が不足しています。まずチャージしてください!")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 42)
                        .padding(.top, 16)

                    HStack(spacing: 15) {
                        Button {
                            cancelBeat()
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
                            chargeBeat()
                        } label: {
                            Text("チャージする")
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
                    .padding(.bottom, 38)
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
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}
