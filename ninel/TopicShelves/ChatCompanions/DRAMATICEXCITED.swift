import SwiftUI

struct DRAMATICEXCITED: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    @State private var whisperStack = ThreadWeave.sharedLedger.whisperStack()

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

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        Text("メンバー")
                            .font(.system(size: 30, weight: .black))
                            .foregroundStyle(.white)

                        Spacer()

                        Button {
                            ThreadWeave.sharedLedger.whisperAnchor(nil)
                            threadRouter.pushThread(.DIRECTIONEPISODE)
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 25, weight: .regular))
                                .foregroundStyle(.white)
                                .frame(width: 44, height: 44)
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
                                .clipShape(Circle())
                        }
                    }
                    

                    VStack(spacing: 16) {
                        ForEach(whisperStack, id: \.echoInk) { whisperShade in
                            WhisperTile(whisperShade: whisperShade)
                        }
                    }
                    .padding(.top, 28)
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 110)
            }

            VStack {
                Spacer()
                TopicDock(currentThread: .DRAMATICEXCITED)
            }
        }
        .onAppear {
            whisperStack = ThreadWeave.sharedLedger.whisperStack()
        }
    }
}

private struct WhisperTile: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    let whisperShade: WhisperShade

    var body: some View {
        Button {
            ThreadWeave.sharedLedger.whisperAnchor(whisperShade.echoInk)
            threadRouter.pushThread(.DISCOVERYTWIST)
        } label: {
            HStack(spacing: 12) {
                WhisperBadge(badgeWhisper: whisperShade.badgeWhisper, badgeSize: 44)

                VStack(alignment: .leading, spacing: 6) {
                    Text(whisperShade.aliasEcho)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(1)

                    HStack(spacing: 5) {
                        Image(systemName: "number.circle.fill")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white.opacity(0.58))

                        Text("\(ThreadWeave.sharedLedger.petals(for: whisperShade).count)つのトピック")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white.opacity(0.50))
                    }
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
            .frame(height: 68)
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
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.white.opacity(0.14), lineWidth: 1)
            )
        }
    }
}
