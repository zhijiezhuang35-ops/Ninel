import SwiftUI
import WebKit

class TopicLedgerPage: UIViewController, WKNavigationDelegate {

    var noteWindow: WKWebView!
    var letterTrail: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let whisperConfig = WKWebViewConfiguration()
        
        noteWindow = WKWebView(frame: self.view.bounds, configuration: whisperConfig)
        noteWindow.navigationDelegate = self
        self.view.addSubview(noteWindow)

       
        if let letterTrail = letterTrail, let noteLink = URL(string: letterTrail) {
            let pageRequest = URLRequest(url: noteLink)
            noteWindow.load(pageRequest)
        }
    }
}

struct ChatLedgerWrap: UIViewControllerRepresentable {
    let topicPath: String

    func makeUIViewController(context: Context) -> TopicLedgerPage {
        let pageBoard = TopicLedgerPage()
        pageBoard.letterTrail = topicPath
        return pageBoard
    }

    func updateUIViewController(_ uiViewController: TopicLedgerPage, context: Context) {
        
    }
}

struct SERIOUSCURIOUS: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    let whisperPath: String
    let ledgerTitle: String
    var body: some View {
        
        
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.18, green: 0.18, blue: 0.17),
                    Color(red: 0.09, green: 0.09, blue: 0.09)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .overlay(alignment: .topTrailing) {
                Circle()
                    .fill(Color(red: 0.35, green: 0.38, blue: 1.0).opacity(0.11))
                    .frame(width: 210, height: 210)
                    .blur(radius: 62)
                    .offset(x: 84, y: 52)
            }.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        threadRouter.popThread()
                    } label: {
                        Image(uiImage: threadEcho(topicFolder: "SuggestorTense", noteFile: "DUOBIANX"))
                                                .resizable()
                                                .frame(width: 7, height: 12)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text(ledgerTitle)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Color.clear
                        .frame(width: 34, height: 34)
                }.padding(.horizontal, 20)
                    .padding(.bottom,20)
                ChatLedgerWrap(topicPath: whisperPath)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
        }
        .threadQuiet()
      
    }
}
