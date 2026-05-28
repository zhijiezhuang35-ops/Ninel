import SwiftUI

struct MONOLOGUEPLAN: View {
    @Binding var threadLinks: [String]
    let closeEcho: () -> Void

    @State private var draftLinks: [String] = []
    @State private var slideWhisper = false

    private var shadeStack: [WhisperShade] {
        ThreadWeave.sharedLedger.whisperStack()
    }

    var body: some View {
        ZStack {
            Color.black.opacity(slideWhisper ? 0.46 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    foldLedger()
                }

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 0) {
                    VStack(spacing: 15) {
                        ForEach(shadeStack, id: \.echoInk) { whisperShade in
                            Button {
                                toggleWhisper(whisperShade.echoInk)
                            } label: {
                                HStack(spacing: 12) {
                                    WhisperBadge(badgeWhisper: whisperShade.badgeWhisper, badgeSize: 25)

                                    Text(whisperShade.aliasEcho)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundStyle(.white)

                                    Spacer()

                                    Image(systemName: draftLinks.contains(whisperShade.echoInk) ? "checkmark" : "")
                                        .font(.system(size: 12, weight: .black))
                                        .foregroundStyle(.white)
                                        .frame(width: 20, height: 20)
                                        .background(
                                            Circle()
                                                .fill(draftLinks.contains(whisperShade.echoInk) ? Color.white.opacity(0.20) : Color.white.opacity(0.12))
                                        )
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white.opacity(draftLinks.contains(whisperShade.echoInk) ? 0.20 : 0.08), lineWidth: 1)
                                        )
                                }
                                .frame(height: 28)
                            }
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 28)

                    Button {
                        commitWhispers()
                    } label: {
                        Text("追加")
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
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 35)
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [
                            Color(red: 0.40, green: 0.38, blue: 0.62),
                            Color(red: 0.09, green: 0.09, blue: 0.09)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .offset(y: slideWhisper ? 0 : 360)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .animation(.spring(response: 0.36, dampingFraction: 0.88), value: slideWhisper)
        .onAppear {
            draftLinks = threadLinks
            DispatchQueue.main.async {
                slideWhisper = true
            }
        }
    }

    private func toggleWhisper(_ echoInk: String) {
        if draftLinks.contains(echoInk) {
            draftLinks.removeAll { $0 == echoInk }
        } else {
            draftLinks.append(echoInk)
        }
    }

    private func commitWhispers() {
        threadLinks = draftLinks
        foldLedger()
    }

    private func foldLedger() {
        withAnimation(.spring(response: 0.30, dampingFraction: 0.92)) {
            slideWhisper = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
            closeEcho()
        }
    }
}
