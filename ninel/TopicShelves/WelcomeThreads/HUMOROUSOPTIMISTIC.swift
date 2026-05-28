import SwiftUI

struct HUMOROUSOPTIMISTIC: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    @EnvironmentObject private var signalRipple: SignalRipple
    @AppStorage("chatmark_policy_tick") private var chatmarkPolicyTick = false
    @AppStorage("topicfolio_policy_gate") private var topicfolioPolicyGate = false
    @State private var dialogueSheet = false
    @State private var notebookRoute: ThreadRoute?
    @State private var phraseGuest = false

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
                    .fill(Color(red: 0.35, green: 0.38, blue: 1.0).opacity(0.16))
                    .frame(width: 210, height: 210)
                    .blur(radius: 62)
                    .offset(x: 80, y: 54)
            }.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer(minLength: 94)
                VStack(spacing: 14) {
                    Image(uiImage: threadEcho(topicFolder: "SuggestorTense", noteFile: "ICON"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))

                    Text("Ninel")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    Button {
                        prepareGuest()
                    } label: {
                        Text("ゲスト利用")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
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
                            .clipShape(Capsule())
                    }
                    
                    
                    Button {
                        prepareThread(.ROMANTICFROWN)
                    } label: {
                        Text("ログイン")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.white)
                            .clipShape(Capsule())
                    }
                }
                .padding(.bottom, 26)
                
                Button {
                    prepareThread(.REMEMBERREUNION)
                } label: {
                    HStack(spacing:0){
                        Text("アカウントがありませんか？")
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundStyle(.white)
                        Text("登録")
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundStyle(Color(red: 128/255, green: 128/255, blue: 236/255),)
                    }
                }.padding(.bottom,39)
                
                
                HStack(spacing: 8) {
                    Button {
                        chatmarkPolicyTick.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color(red: 0.30, green: 0.39, blue: 1.0), lineWidth: 1.2)

                            if chatmarkPolicyTick {
                                Circle()
                                    .fill(Color(red: 0.30, green: 0.39, blue: 1.0))

                                Image(systemName: "checkmark")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                        }
                            .frame(width: 13, height: 13)
                    }

                    HStack(spacing: 0) {
                        Button {
                            threadRouter.pushThread(.SERIOUSCURIOUS("https://app.31znvnu0.link/users", "利用規約"))
                        } label: {
                            Text("利用規約")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(Color(red: 0.40, green: 0.48, blue: 1.0))
                        }

                        Text("および")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.77))

                        Button {
                            threadRouter.pushThread(.SERIOUSCURIOUS("https://app.31znvnu0.link/privacy", "プライバシーポリシー"))
                        } label: {
                            Text("プライバシーポリシー")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(Color(red: 0.40, green: 0.48, blue: 1.0))
                        }

                        Text("に同意する")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.77))
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.76)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            
            }
            .padding(.horizontal, 36)

            if dialogueSheet {
                MOTIVATIONFRIENDLY {
                    withAnimation(.easeInOut(duration: 0.22)) {
                        dialogueSheet = false
                    }
                } agreeThread: {
                    topicfolioPolicyGate = true
                    withAnimation(.easeInOut(duration: 0.22)) {
                        dialogueSheet = false
                    }
                    if phraseGuest {
                        phraseGuest = false
                        signalRipple.holdEcho("ログイン中") {
                            MurmurArchive.sharedArchive.guestPage()
                            threadRouter.replaceThread(.LIVINGROOMMIDDLE)
                        }
                    } else if let notebookRoute {
                        threadRouter.pushThread(notebookRoute)
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(2)
            }
           
        }
       
    }

    private func prepareThread(_ routeThread: ThreadRoute) {
        phraseGuest = false
        guard chatmarkPolicyTick else {
            signalRipple.noteBloom("利用規約に同意してください", noteShade: .warnTone)
            return
        }

        guard topicfolioPolicyGate else {
            notebookRoute = routeThread
            withAnimation(.easeInOut(duration: 0.22)) {
                dialogueSheet = true
            }
            return
        }

        threadRouter.pushThread(routeThread)
    }

    private func prepareGuest() {
        guard chatmarkPolicyTick else {
            signalRipple.noteBloom("利用規約に同意してください", noteShade: .warnTone)
            return
        }

        guard topicfolioPolicyGate else {
            notebookRoute = nil
            phraseGuest = true
            withAnimation(.easeInOut(duration: 0.22)) {
                dialogueSheet = true
            }
            return
        }

        signalRipple.holdEcho("ログイン中") {
            MurmurArchive.sharedArchive.guestPage()
            threadRouter.replaceThread(.LIVINGROOMMIDDLE)
        }
    }

}
