import Photos
import PhotosUI
import SwiftUI

struct DIRECTIONEPISODE: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    @EnvironmentObject private var signalRipple: SignalRipple
    @State private var whisperName = ""
    @State private var ledgerBody = ""
    @State private var badgeWhisper = "hue:FF5538"
    @State private var didLoad = false
    @State private var pickerShown = false

    private let hueStack = ["hue:FF5538", "hue:FF8C1A", "hue:2F8DE4", "hue:3DD07D", "hue:7445E2"]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.18, green: 0.18, blue: 0.17),
                    Color(red: 0.08, green: 0.08, blue: 0.08)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        threadRouter.popThread()
                    } label: {
                        Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "DUOBIANX"))
                            .resizable()
                            .frame(width: 6, height: 12)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("キャラクターを追加")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Color.clear
                        .frame(width: 40, height: 40)
                }

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("氏名")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)

                            TextField("", text: $whisperName, prompt: Text("入力してください").foregroundColor(.white.opacity(0.42)))
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 14)
                                .frame(height: 48)
                                .background(Color.white.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .stroke(Color.white.opacity(0.24), lineWidth: 1)
                                )
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("備考")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)

                            ZStack(alignment: .topLeading) {
                                WhisperDraft(ledgerText: $ledgerBody)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 14)
                                    .frame(height: 128)
                                    .background(Color.white.opacity(0.12))
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .stroke(Color.white.opacity(0.24), lineWidth: 1)
                                    )

                                if ledgerBody.isEmpty {
                                    Text("入力してください")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(.white.opacity(0.42))
                                        .padding(.top, 14)
                                        .padding(.leading, 14)
                                        .allowsHitTesting(false)
                                }
                            }
                        }
                        .padding(.top, 26)

                        VStack(alignment: .leading, spacing: 16) {
                            Text("プロフィール画像")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)

                            HStack(spacing: 20) {
                                ForEach(hueStack, id: \.self) { hueWhisper in
                                    Button {
                                        badgeWhisper = hueWhisper
                                    } label: {
                                        HueDot(hueWhisper: hueWhisper, echoChosen: badgeWhisper == hueWhisper)
                                    }
                                }
                            }

                            Text("カスタムプロフィール画像")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(.white.opacity(0.42))

                            Button {
                                photoLedger()
                            } label: {
                                ZStack {
                                    if Color.threadTint(from: badgeWhisper) == nil {
                                        UploadEcho(badgeWhisper: badgeWhisper)
                                    } else {
                                        Image(systemName: "plus")
                                            .font(.system(size: 27, weight: .regular))
                                            .foregroundStyle(.white)
                                    }
                                }
                                .frame(width: 83, height: 83)
                                .background(Color.white.opacity(0.10))
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .stroke(Color.white.opacity(0.10), lineWidth: 1)
                                )
                            }
                        }
                        .padding(.top, 28)
                        
                        Button {
                            saveWhisper()
                        } label: {
                            Text(ThreadWeave.sharedLedger.whisperFocus() == nil ? "追加" : "保存")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
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
                        .padding(.bottom, 36)
                        .padding(.top,60)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 28)
                }

      
            }
            .padding(.horizontal, 20)
        }
        .threadQuiet()
        .onAppear {
            shadePrelude()
        }
        .sheet(isPresented: $pickerShown) {
            ThreadPicker(badgeWhisper: $badgeWhisper)
        }
    }

    private func shadePrelude() {
        guard didLoad == false else { return }
        didLoad = true

        guard let whisperShade = ThreadWeave.sharedLedger.whisperFocus() else {
            return
        }

        whisperName = whisperShade.aliasEcho
        ledgerBody = whisperShade.asideThread
        badgeWhisper = whisperShade.badgeWhisper
    }

    private func photoLedger() {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized, .limited:
            pickerShown = true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { noteStatus in
                DispatchQueue.main.async {
                    if noteStatus == .authorized || noteStatus == .limited {
                        pickerShown = true
                    }
                }
            }
        case .denied, .restricted:
            break
        @unknown default:
            break
        }
    }

    private func saveWhisper() {
        guard whisperName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false,
              ledgerBody.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            signalRipple.noteBloom("入力してください", noteShade: .warnTone)
            return
        }

        signalRipple.holdEcho(ThreadWeave.sharedLedger.whisperFocus() == nil ? "追加中" : "保存中") {
            ThreadWeave.sharedLedger.whisperFold(aliasEcho: whisperName, asideThread: ledgerBody, badgeWhisper: badgeWhisper)
            threadRouter.replaceThread(.DRAMATICEXCITED)
        }
    }
}

private struct HueDot: View {
    let hueWhisper: String
    let echoChosen: Bool

    var body: some View {
        Circle()
            .fill(Color.threadTint(from: hueWhisper) ?? .white.opacity(0.18))
            .frame(width: 42, height: 42)
            .overlay(
                Circle()
                    .stroke(echoChosen ? Color.white.opacity(0.52) : Color.clear, lineWidth: 2)
            )
    }
}

private struct UploadEcho: View {
    let badgeWhisper: String

    var body: some View {
        Group {
            if let imageEcho = UIImage.threadImage(from: badgeWhisper) {
                Image(uiImage: imageEcho)
                    .resizable()
                    .scaledToFill()
            } else if Color.threadTint(from: badgeWhisper) == nil {
                Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: badgeWhisper))
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "plus")
                    .font(.system(size: 27, weight: .regular))
                    .foregroundStyle(.white)
            }
        }
        .frame(width: 83, height: 83)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

private struct ThreadPicker: UIViewControllerRepresentable {
    @Binding var badgeWhisper: String

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var pickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        pickerConfig.filter = .images
        pickerConfig.selectionLimit = 1

        let pickerView = PHPickerViewController(configuration: pickerConfig)
        pickerView.delegate = context.coordinator
        return pickerView
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    func makeCoordinator() -> ThreadGuide {
        ThreadGuide(badgeWhisper: $badgeWhisper)
    }
}

private final class ThreadGuide: NSObject, PHPickerViewControllerDelegate {
    @Binding private var badgeWhisper: String

    init(badgeWhisper: Binding<String>) {
        _badgeWhisper = badgeWhisper
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else {
            return
        }

        itemProvider.loadObject(ofClass: UIImage.self) { imageObject, _ in
            guard let imageEcho = imageObject as? UIImage, let imageData = imageEcho.jpegData(compressionQuality: 0.86) else {
                return
            }

            let imageName = "thread_\(UUID().uuidString).jpg"
            guard let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(imageName) else {
                return
            }

            do {
                try imageData.write(to: imageURL)
                DispatchQueue.main.async {
                    self.badgeWhisper = "file:\(imageName)"
                }
            } catch {
            }
        }
    }
}
