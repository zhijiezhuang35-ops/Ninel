import SwiftUI

struct VoiceRibbon: View {
    let whisperName: String
    let echoMinus: Bool

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.82))
                    .frame(width: 28, height: 28)

                Image(systemName: "person.fill")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Color.black.opacity(0.30))
            }

            Text(whisperName)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.white)

            Spacer()

            if echoMinus {
                Image(systemName: "minus")
                    .font(.system(size: 10, weight: .black))
                    .foregroundStyle(.white)
                    .frame(width: 18, height: 18)
                    .background(Color(red: 1.0, green: 0.27, blue: 0.16))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 48)
        .background(Color.white.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.white.opacity(0.24), lineWidth: 1)
        )
    }
}
