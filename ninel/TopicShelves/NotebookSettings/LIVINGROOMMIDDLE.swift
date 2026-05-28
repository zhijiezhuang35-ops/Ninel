import Combine
import SwiftUI

struct LIVINGROOMMIDDLE: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    @State private var threadStack = ThreadWeave.sharedLedger.threadStack()
    @State private var tagEcho = "すべて"
    @State private var noteAnchored = false
    @State private var clockThread = Date()
    @State private var notebookGate = false
    
    private let markStack = [
        ("すべて", ""),
        ("仕事", "💼"),
        ("趣味", "🎨"),
        ("旅行", "✈️"),
        ("グルメ", "🍜")
    ]
    
    private var threadPetals: [NotePetal] {
        tagEcho == "すべて" ? threadStack : threadStack.filter { $0.tagEcho == tagEcho }
    }
    
    var body: some View {
        GeometryReader { topicCanvas in
            ZStack(alignment: .top) {
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
                    VStack(spacing: 0) {
                        HStack(alignment: .center) {
                            ZStack(alignment: .leading) {
                                Text("Ninel")
                                    .font(.system(size: 28, weight: .black, design: .rounded))
                                    .foregroundStyle(Color(red: 0.23, green: 0.27, blue: 1.0))
                                    .offset(x: -3, y: 2)

                                Text("Ninel")
                                    .font(.system(size: 28, weight: .black, design: .rounded))
                                    .foregroundStyle(.white)
                            }

                            Spacer()
                            
                            Button {
                                guard MurmurArchive.sharedArchive.guestLedger() == false else {
                                    withAnimation(.easeInOut(duration: 0.22)) {
                                        notebookGate = true
                                    }
                                    return
                                }
                                ThreadWeave.sharedLedger.threadAnchor(nil)
                                threadRouter.pushThread(.BEGINNINGOFCOURSE)
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .regular))
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
                        .padding(.horizontal, 14)
                        .padding(.top, 45)

                        Button {
                            guard MurmurArchive.sharedArchive.guestLedger() == false else {
                                withAnimation(.easeInOut(duration: 0.22)) {
                                    notebookGate = true
                                }
                                return
                            }
                            threadRouter.pushThread(.INTRODUCTIONJOYFUL)
                        } label: {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("AIアシスタント")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(.white)

                                    Text("トピックを素早く整理するお手伝いを")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundStyle(.white.opacity(0.52))

                                    Spacer(minLength: 0)

                                    Image(systemName: "arrow.up.right")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.white)
                                        .frame(width: 32, height: 32)
                                        .background(Color.white.opacity(0.18))
                                        .clipShape(Circle())
                                }

                                Spacer()
                                Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DAXING"))
                                    .resizable()
                                    .frame(width: 94, height: 94)
                                    .padding(.trailing,16)
                            }
                            .padding(.leading, 14)
                            .padding(.vertical, 15)
                            .frame(height: 126)
                            .frame(maxWidth: .infinity)
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
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 14)
                    }
                    
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        Section {
                            VStack(spacing: 20) {
                                ForEach(threadPetals, id: \.pageInk) { threadPetal in
                                    LedgerPane(threadPetal: threadPetal, clockThread: clockThread)
                                }
                            }
                            .padding(.top, 20)
                            .padding(.horizontal, 14)
                            .padding(.bottom, 110)
                        } header: {
                            VStack(spacing: 0) {
                                if noteAnchored {
                                    Color.clear
                                        .frame(height: topicCanvas.safeAreaInsets.top + 34)
                                }

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(markStack, id: \.0) { threadPair in
                                            Button {
                                                tagEcho = threadPair.0
                                            } label: {
                                                MurmurToken(whisperLabel: threadPair.0, glyphEcho: threadPair.1, echoChosen: tagEcho == threadPair.0)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 14)
                                    .padding(.top, 10)
                                    .padding(.bottom, noteAnchored ? 20 : 10)
                                }
                            }
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.18, green: 0.18, blue: 0.17),
                                        Color(red: 0.12, green: 0.12, blue: 0.12)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .ignoresSafeArea(.container, edges: .top)
                            )
                            .offset(y: noteAnchored ? -topicCanvas.safeAreaInsets.top : 0)
                            .padding(.bottom, noteAnchored ? -(topicCanvas.safeAreaInsets.top + 34) : 0)
                            .background(
                                TopicAnchorMark { noteValue in
                                    let noteLimit = topicCanvas.safeAreaInsets.top + 2
                                    let nextThread = noteValue <= noteLimit
                                    if noteAnchored != nextThread {
                                        withAnimation(.easeOut(duration: 0.18)) {
                                            noteAnchored = nextThread
                                        }
                                    }
                                }
                            )
                            .zIndex(5)
                        }
                    }
                }
                .coordinateSpace(name: "threadScroll")
                .ignoresSafeArea(.container, edges: .top)
                
                VStack {
                    Spacer()
                    TopicDock(currentThread: .LIVINGROOMMIDDLE) {
                        withAnimation(.easeInOut(duration: 0.22)) {
                            notebookGate = true
                        }
                    }
                }

                if notebookGate {
                    NotebookGate {
                        withAnimation(.easeInOut(duration: 0.22)) {
                            notebookGate = false
                        }
                    } loginThread: {
                        withAnimation(.easeInOut(duration: 0.22)) {
                            notebookGate = false
                        }
                        threadRouter.pushThread(.ROMANTICFROWN)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(6)
                }
            }
        }
        .onAppear {
            threadStack = ThreadWeave.sharedLedger.threadStack()
        }
        .onReceive(Timer.publish(every: 60, on: .main, in: .common).autoconnect()) { noteClock in
            clockThread = noteClock
        }
    }
}

private struct LedgerPane: View {
    @EnvironmentObject private var threadRouter: ThreadRouter

    let threadPetal: NotePetal
    let clockThread: Date

    var body: some View {
        Button {
            ThreadWeave.sharedLedger.threadAnchor(threadPetal.pageInk)
            threadRouter.pushThread(.EMOTIONALGESTURE)
        } label: {
            HStack(alignment: .bottom, spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(threadPetal.pageWhisper)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(1)

                    HStack(spacing: 5) {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white.opacity(0.58))

                        Text("\(threadPetal.echoLinks.count)人")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.white.opacity(0.58))

                        Text(threadPetal.timeWhisper)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.white.opacity(0.58))
                            .id(clockThread)
                    }

                    Text("#\(threadPetal.tagEcho)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white.opacity(0.52))
                        .padding(.horizontal, 10)
                        .frame(height: 24)
                        .background(Color.white.opacity(0.08))
                        .clipShape(Capsule())
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
            .frame(height: 106)
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
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.14), lineWidth: 1)
            )
        }
    }
}

private struct TopicAnchorMark: View {
    let noteBeat: (CGFloat) -> Void

    var body: some View {
        GeometryReader { noteProxy in
            let noteValue = noteProxy.frame(in: .global).minY

            Color.clear
                .onAppear {
                    noteBeat(noteValue)
                }
                .onChange(of: noteValue) { nextValue in
                    noteBeat(nextValue)
                }
        }
        .frame(height: 1)
    }
}
