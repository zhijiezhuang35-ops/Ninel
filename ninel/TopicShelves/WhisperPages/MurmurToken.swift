import SwiftUI

struct MurmurToken: View {
    let whisperLabel: String
    let memoGlyph: String
    let echoChosen: Bool

    var body: some View {
        HStack(spacing: 5) {
            if !memoGlyph.isEmpty {
                Text(memoGlyph)
                    .font(.system(size: 13))
            }

            Text(whisperLabel)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(echoChosen ? .black : .white.opacity(0.88))
        }
        .padding(.horizontal, echoChosen ? 16 : 13)
        .frame(height: 44)
        .background(echoChosen ? Color.white : Color.white.opacity(0.12))
        .clipShape(Capsule())
    }
}
