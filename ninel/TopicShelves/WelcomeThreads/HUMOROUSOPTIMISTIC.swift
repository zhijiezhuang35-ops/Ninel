import SwiftUI

struct HUMOROUSOPTIMISTIC: View {
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
                    } label: {
                        Text("登録")
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
                } label: {
                    HStack(spacing: 8) {
                        Circle()
                            .stroke(Color(red: 0.30, green: 0.39, blue: 1.0), lineWidth: 1.2)
                            .frame(width: 13, height: 13)

                        Text("利用規約およびプライバシーポリシーに同意する")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.77))
                            .lineLimit(1)
                            .minimumScaleFactor(0.78)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                }
                
            
            }
            .padding(.horizontal, 36)
           
        }
       
    }

}
