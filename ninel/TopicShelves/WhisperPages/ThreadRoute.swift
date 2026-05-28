import SwiftUI
import Combine
import UIPilot

enum ThreadRoute: Hashable {
    case HUMOROUSOPTIMISTIC
    case ROMANTICFROWN
    case REMEMBERREUNION
    case SUSPENSEIKNOW
    case LIVINGROOMMIDDLE
    case INTRODUCTIONJOYFUL
    case AGGRESSIVELINES(String)
    case BEGINNINGOFCOURSE
    case EMOTIONALGESTURE
    case DRAMATICEXCITED
    case DIRECTIONEPISODE
    case DISCOVERYTWIST
    case ANSWERDISCUSS
    case DIALOGUEARRIVAL
    case REFLECTIVEBITTER
    case SERIOUSCURIOUS(String, String)
}

final class ThreadRouter: ObservableObject {
    @Published private(set) var topicPilot: UIPilot<ThreadRoute>
    @Published private(set) var threadToken = UUID()

    var currentThread: ThreadRoute {
        topicPilot.routes.last ?? .HUMOROUSOPTIMISTIC
    }

    init(startThread: ThreadRoute = .HUMOROUSOPTIMISTIC) {
        topicPilot = UIPilot(initial: startThread)
    }

    func pushThread(_ targetThread: ThreadRoute) {
        topicPilot.push(targetThread)
    }

    func replaceThread(_ targetThread: ThreadRoute) {
        topicPilot = UIPilot(initial: targetThread)
        threadToken = UUID()
    }

    func popThread() {
        guard topicPilot.routes.count > 1 else { return }
        topicPilot.pop()
    }
}

struct ThreadRoot: View {
    @StateObject private var threadRouter: ThreadRouter
    @StateObject private var signalRipple = SignalRipple()

    init() {
        let startThread: ThreadRoute = MurmurArchive.sharedArchive.currentScroll() == nil && MurmurArchive.sharedArchive.guestLedger() == false ? .HUMOROUSOPTIMISTIC : .LIVINGROOMMIDDLE
        _threadRouter = StateObject(wrappedValue: ThreadRouter(startThread: startThread))
    }

    var body: some View {
        ZStack {
            UIPilotHost(threadRouter.topicPilot) { currentThread in
                threadScene(for: currentThread)
                    .uipNavigationBarHidden(true)
            }
            .id(threadRouter.threadToken)

            SignalLayer(signalRipple: signalRipple)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(9999)
        }
        .ignoresSafeArea()
        .environmentObject(threadRouter)
        .environmentObject(signalRipple)
    }

    @ViewBuilder
    private func threadScene(for currentThread: ThreadRoute) -> some View {
        switch currentThread {
        case .HUMOROUSOPTIMISTIC:
            HUMOROUSOPTIMISTIC()
        case .ROMANTICFROWN:
            ROMANTICFROWN()
        case .REMEMBERREUNION:
            REMEMBERREUNION()
        case .SUSPENSEIKNOW:
            SUSPENSEIKNOW()
        case .LIVINGROOMMIDDLE:
            LIVINGROOMMIDDLE()
        case .INTRODUCTIONJOYFUL:
            INTRODUCTIONJOYFUL()
        case .AGGRESSIVELINES(let noteText):
            AGGRESSIVELINES(ledgerBody: noteText)
        case .BEGINNINGOFCOURSE:
            BEGINNINGOFCOURSE()
        case .EMOTIONALGESTURE:
            EMOTIONALGESTURE()
        case .DRAMATICEXCITED:
            DRAMATICEXCITED()
        case .DIRECTIONEPISODE:
            DIRECTIONEPISODE()
        case .DISCOVERYTWIST:
            DISCOVERYTWIST()
        case .ANSWERDISCUSS:
            ANSWERDISCUSS()
        case .DIALOGUEARRIVAL:
            DIALOGUEARRIVAL()
        case .REFLECTIVEBITTER:
            REFLECTIVEBITTER()
        case .SERIOUSCURIOUS(let whisperPath, let ledgerTitle):
            SERIOUSCURIOUS(whisperPath: whisperPath, ledgerTitle: ledgerTitle)
        }
    }
}
