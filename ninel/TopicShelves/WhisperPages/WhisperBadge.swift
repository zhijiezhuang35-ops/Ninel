import SwiftUI

struct WhisperBadge: View {
    let badgeWhisper: String
    let badgeSize: CGFloat

    var body: some View {
        Group {
            if let tintColor = Color.threadTint(from: badgeWhisper) {
                Circle()
                    .fill(tintColor)
            } else if let imageEcho = UIImage.threadImage(from: badgeWhisper) {
                Image(uiImage: imageEcho)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: badgeWhisper))
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: badgeSize, height: badgeSize)
        .clipShape(Circle())
    }
}

extension Color {
    static func threadTint(from badgeWhisper: String) -> Color? {
        guard badgeWhisper.hasPrefix("hue:") else {
            return nil
        }

        let tintCode = String(badgeWhisper.dropFirst(4))
        guard tintCode.count == 6, let tintValue = Int(tintCode, radix: 16) else {
            return nil
        }

        return Color(
            red: Double((tintValue >> 16) & 0xFF) / 255.0,
            green: Double((tintValue >> 8) & 0xFF) / 255.0,
            blue: Double(tintValue & 0xFF) / 255.0
        )
    }
}

extension UIImage {
    static func threadImage(from badgeWhisper: String) -> UIImage? {
        guard badgeWhisper.hasPrefix("file:") else {
            return nil
        }

        let imageName = String(badgeWhisper.dropFirst(5))
        guard let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(imageName).path else {
            return nil
        }

        return UIImage(contentsOfFile: imagePath)
    }
}
