import SwiftUI
import UIKit

struct WhisperDraft: UIViewRepresentable {
    @Binding var ledgerText: String
    var echoFont: UIFont = .systemFont(ofSize: 14, weight: .medium)
    var echoColor: UIColor = .white
    var echoScroll: Bool = true

    func makeUIView(context: Context) -> UITextView {
        let threadView = UITextView()
        threadView.backgroundColor = .clear
        threadView.textColor = echoColor
        threadView.font = echoFont
        threadView.textContainerInset = .zero
        threadView.textContainer.lineFragmentPadding = 0
        threadView.isScrollEnabled = echoScroll
        threadView.delegate = context.coordinator
        return threadView
    }

    func updateUIView(_ threadView: UITextView, context: Context) {
        threadView.textColor = echoColor
        threadView.font = echoFont
        threadView.isScrollEnabled = echoScroll

        if threadView.text != ledgerText {
            threadView.text = ledgerText
        }
    }

    func makeCoordinator() -> EchoBridge {
        EchoBridge(ledgerText: $ledgerText)
    }

    final class EchoBridge: NSObject, UITextViewDelegate {
        @Binding var ledgerText: String

        init(ledgerText: Binding<String>) {
            _ledgerText = ledgerText
        }

        func textViewDidChange(_ threadView: UITextView) {
            ledgerText = threadView.text
        }
    }
}
