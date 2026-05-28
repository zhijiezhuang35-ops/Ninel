import SwiftUI
import Combine

enum RippleShade {
    case noteTone
    case warnTone
}

final class SignalRipple: ObservableObject {
    @Published var noteLine: String?
    @Published var noteShade: RippleShade = .noteTone
    @Published var holdLine: String?

    private var driftWork: DispatchWorkItem?

    func noteBloom(_ noteText: String, noteShade: RippleShade = .noteTone) {
        driftWork?.cancel()

        withAnimation(.spring(response: 0.28, dampingFraction: 0.86)) {
            self.noteLine = noteText
            self.noteShade = noteShade
        }

        let driftWork = DispatchWorkItem { [weak self] in
            DispatchQueue.main.async {
                self?.noteDrift()
            }
        }

        self.driftWork = driftWork
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: driftWork)
    }

    func noteDrift() {
        withAnimation(.easeInOut(duration: 0.22)) {
            noteLine = nil
        }
    }

    func holdBloom(_ noteText: String = "読み込み中") {
        withAnimation(.easeInOut(duration: 0.18)) {
            holdLine = noteText
        }
    }

    func holdDrift() {
        withAnimation(.easeInOut(duration: 0.18)) {
            holdLine = nil
        }
    }

    func holdEcho(_ noteText: String = "読み込み中", threadBeat: @escaping () -> Void) {
        holdBloom(noteText)

        let echoDelay = Double.random(in: 0.7...1.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + echoDelay) { [weak self] in
            self?.holdDrift()
            threadBeat()
        }
    }
}

struct SignalLayer: View {
    @ObservedObject var signalRipple: SignalRipple

    var body: some View {
        ZStack {
            if let holdLine = signalRipple.holdLine {
                ThreadVeil(holdLine: holdLine)
                    .transition(.opacity)
                    .zIndex(9998)
            }

            if let noteLine = signalRipple.noteLine {
                VStack {
                    Spacer()

                    NoteBanner(noteLine: noteLine, noteShade: signalRipple.noteShade)
                        .padding(.bottom, 44)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(9999)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .allowsHitTesting(signalRipple.holdLine != nil)
    }
}

private struct ThreadVeil: View {
    let holdLine: String

    var body: some View {
        ZStack {
            Color.black.opacity(0.40)
                .ignoresSafeArea()

            VStack(spacing: 14) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .scaleEffect(1.15)

                Text(holdLine)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(width: 142, height: 112)
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.29, green: 0.28, blue: 0.43).opacity(0.96),
                        Color(red: 0.10, green: 0.10, blue: 0.10).opacity(0.96)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color.white.opacity(0.16), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.35), radius: 22, x: 0, y: 14)
        }
    }
}

private struct NoteBanner: View {
    let noteLine: String
    let noteShade: RippleShade

    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(noteColor)
                .frame(width: 8, height: 8)

            Text(noteLine)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 48)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color.white.opacity(0.18),
                    Color.white.opacity(0.10)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.white.opacity(0.16), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.30), radius: 18, x: 0, y: 10)
        .padding(.horizontal, 18)
    }

    private var noteColor: Color {
        switch noteShade {
        case .noteTone:
            return Color(red: 0.42, green: 0.50, blue: 1.0)
        case .warnTone:
            return Color(red: 1.0, green: 0.23, blue: 0.13)
        }
    }
}
