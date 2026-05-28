import SwiftUI
import UIKit

extension View {
    func threadQuiet() -> some View {
        background(ThreadQuietLayer())
    }
}

private struct ThreadQuietLayer: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let noteView = QuietAnchor(frame: .zero)
        noteView.threadBridge = context.coordinator
        return noteView
    }

    func updateUIView(_ noteView: UIView, context: Context) {
        guard let noteView = noteView as? QuietAnchor else { return }
        noteView.threadBridge = context.coordinator
        noteView.bindQuiet()
    }

    func makeCoordinator() -> ThreadBridge {
        ThreadBridge()
    }
    
    final class ThreadBridge: NSObject, UIGestureRecognizerDelegate {
        @objc func noteQuiet() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }

        func gestureRecognizer(_ topicTap: UIGestureRecognizer, shouldReceive topicTouch: UITouch) -> Bool {
            var noteView = topicTouch.view

            while let topicView = noteView {
                if topicView is UITextField || topicView is UITextView || topicView is UIControl {
                    return false
                }

                noteView = topicView.superview
            }

            return true
        }
    }
}

private final class QuietAnchor: UIView {
    weak var threadBridge: ThreadQuietLayer.ThreadBridge?
    private weak var topicWindow: UIWindow?
    private var topicTap: UITapGestureRecognizer?

    deinit {
        if let topicTap, let topicWindow {
            topicWindow.removeGestureRecognizer(topicTap)
        }
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        bindQuiet()
    }

    func bindQuiet() {
        guard topicWindow !== window else { return }

        if let topicTap, let topicWindow {
            topicWindow.removeGestureRecognizer(topicTap)
        }

        topicWindow = window

        guard let window, let threadBridge else {
            topicTap = nil
            return
        }

        let noteTap = UITapGestureRecognizer(target: threadBridge, action: #selector(ThreadQuietLayer.ThreadBridge.noteQuiet))
        noteTap.cancelsTouchesInView = false
        noteTap.delegate = threadBridge
        window.addGestureRecognizer(noteTap)
        topicTap = noteTap
    }
}
