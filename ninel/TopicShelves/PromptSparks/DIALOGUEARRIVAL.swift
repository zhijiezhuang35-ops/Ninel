import SwiftUI
import StoreKit

struct DIALOGUEARRIVAL: View {
    @EnvironmentObject private var threadRouter: ThreadRouter
    @EnvironmentObject private var signalRipple: SignalRipple
    @State private var pricePulse = UUID()
    @State private var noteSpark = MurmurArchive.sharedArchive.currentScroll()?.sparkTally ?? 0
    
    private let echoPairs = [
        WhisperBundle(sparkCount: 400, fallbackPrice: "$ 0.99", ledgerInk: "hypgsoihcalsoima"),
        WhisperBundle(sparkCount: 800, fallbackPrice: "$ 1.99", ledgerInk: "tymjgvlzicedwore"),
        WhisperBundle(sparkCount: 1780, fallbackPrice: "$ 3.99", ledgerInk: "xaoihsmplgocisah"),
        WhisperBundle(sparkCount: 2450, fallbackPrice: "$ 4.99", ledgerInk: "qoddocruwupeheqn"),
        WhisperBundle(sparkCount: 5110, fallbackPrice: "$ 9.99", ledgerInk: "izrpmbylhfrdpbso"),
        WhisperBundle(sparkCount: 10800, fallbackPrice: "$ 19.99", ledgerInk: "tvvizrepglrgvzvs"),
        WhisperBundle(sparkCount: 14900, fallbackPrice: "$ 29.99", ledgerInk: "mioshcapglysoiah"),
        WhisperBundle(sparkCount: 29400, fallbackPrice: "$ 49.99", ledgerInk: "exitssjriqqxliff"),
        WhisperBundle(sparkCount: 34500, fallbackPrice: "$ 69.99", ledgerInk: "gshoiacmspolihya"),
        WhisperBundle(sparkCount: 63700, fallbackPrice: "$ 99.99", ledgerInk: "wbsvodrplckjhcga")
    ]
    
    var body: some View {
        let _ = pricePulse
        
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

                    Text("チャージ")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Color.clear
                        .frame(width: 40, height: 40)
                }
                
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("残高")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white.opacity(0.54))

                        Text("\(noteSpark)")
                            .font(.system(size: 18, weight: .black))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "KZXJCBQZS"))
                        .resizable()
                        .frame(width: 72, height: 72)
                        .padding(.trailing, 20)
                }
                .padding(.leading, 14)
                .frame(height: 72)
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
                .padding(.top, 24)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 15),
                            GridItem(.flexible(), spacing: 15)
                        ],
                        spacing: 18
                    ) {
                        ForEach(echoPairs) { echoPair in
                            PhraseOffer(
                                noteBundle: echoPair,
                                whisperPrice: TopicVault.sharedVault.priceText(for: echoPair)
                            ) {
                                buyLedger(echoPair)
                            }
                        }
                    }
                    .padding(.top, 20)
                }
            }
            .padding(.horizontal, 14)
        }
        .onAppear {
            noteSpark = MurmurArchive.sharedArchive.currentScroll()?.sparkTally ?? 0
            TopicVault.sharedVault.bindNotebook(
                echoPairs,
                priceBeat: {
                    pricePulse = UUID()
                },
                resultBeat: handleLedger(_:)
            )
        }
        .onDisappear {
            TopicVault.sharedVault.looseNotebook()
        }
    }

    private func buyLedger(_ noteBundle: WhisperBundle) {
        guard TopicVault.sharedVault.canBuy(noteBundle) else {
            signalRipple.noteBloom("商品を取得できません", noteShade: .warnTone)
            return
        }

        signalRipple.holdBloom("購入中")
        TopicVault.sharedVault.buyLedger(noteBundle)
    }

    private func handleLedger(_ topicResult: TopicResult) {
        signalRipple.holdDrift()

        switch topicResult {
        case .done(let sparkCount):
            if let scrollNote = MurmurArchive.sharedArchive.sparkGather(sparkCount) {
                noteSpark = scrollNote.sparkTally
            } else {
                noteSpark += sparkCount
            }
            signalRipple.noteBloom("チャージしました")
        case .failed(let noteText):
            signalRipple.noteBloom(noteText, noteShade: .warnTone)
        }
    }
}

private struct PhraseOffer: View {
    let noteBundle: WhisperBundle
    let whisperPrice: String
    let threadBeat: () -> Void

    var body: some View {
        Button {
            threadBeat()
        } label: {
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Image(uiImage: journalPicture(topicFolder: "SuggestorTense", noteFile: "KZXJCBQZS"))
                        .resizable()
                        .frame(width: 40, height: 40)

                    Text("\(noteBundle.sparkCount)")
                        .font(.system(size: 18, weight: .black))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                }
                .padding(.top, 10)

                Text(whisperPrice)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                    .frame(width: 100, height: 28)
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
                    .padding(.top, 6)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 90)
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
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
        }
    }
}

private struct WhisperBundle: Identifiable, Hashable {
    let sparkCount: Int
    let fallbackPrice: String
    let ledgerInk: String

    var id: String {
        ledgerInk
    }
}

private enum TopicResult {
    case done(Int)
    case failed(String)
}

private final class TopicVault: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let sharedVault = TopicVault()

    private var requestBook: SKProductsRequest?
    private var bundleBook: [String: WhisperBundle] = [:]
    private var productBook: [String: SKProduct] = [:]
    private var priceBeat: (() -> Void)?
    private var resultBeat: ((TopicResult) -> Void)?
    private var activeLedger: String?
    private var pauseUntil = Date.distantPast
    private var markShelf: Set<String> = []
    private let receiptMark = "topic_vault_receipt_marks"

    override init() {
        super.init()
        markShelf = Set(UserDefaults.standard.stringArray(forKey: receiptMark) ?? [])
        SKPaymentQueue.default().add(self)
    }

    func bindNotebook(
        _ noteBundles: [WhisperBundle],
        priceBeat: @escaping () -> Void,
        resultBeat: @escaping (TopicResult) -> Void
    ) {
        self.priceBeat = priceBeat
        self.resultBeat = resultBeat
        openLedger(noteBundles)
    }

    func looseNotebook() {
        priceBeat = nil
        resultBeat = nil
    }

    func openLedger(_ noteBundles: [WhisperBundle]) {
        bundleBook = Dictionary(uniqueKeysWithValues: noteBundles.map { ($0.ledgerInk, $0) })
        requestBook?.cancel()

        let productStack = Set(noteBundles.map(\.ledgerInk))
        let requestBook = SKProductsRequest(productIdentifiers: productStack)
        requestBook.delegate = self
        self.requestBook = requestBook
        requestBook.start()
    }

    func canBuy(_ noteBundle: WhisperBundle) -> Bool {
        SKPaymentQueue.canMakePayments() && productBook[noteBundle.ledgerInk] != nil
    }

    func priceText(for noteBundle: WhisperBundle) -> String {
        noteBundle.fallbackPrice
    }

    func buyLedger(_ noteBundle: WhisperBundle) {
        guard activeLedger == nil, Date() >= pauseUntil else {
            resultBeat?(.failed("処理中です"))
            return
        }

        guard let pricePaper = productBook[noteBundle.ledgerInk] else {
            resultBeat?(.failed("商品を取得できません"))
            return
        }

        activeLedger = noteBundle.ledgerInk
        let paymentNote = SKPayment(product: pricePaper)
        SKPaymentQueue.default().add(paymentNote)
    }

    func productsRequest(_ requestLine: SKProductsRequest, didReceive responseBook: SKProductsResponse) {
        var productStack: [String: SKProduct] = [:]
        responseBook.products.forEach { productStack[$0.productIdentifier] = $0 }
        productBook = productStack
        priceBeat?()
    }

    func request(_ requestLine: SKRequest, didFailWithError errorLine: Error) {
        resultBeat?(.failed("商品を取得できません"))
    }

    func paymentQueue(_ queueBook: SKPaymentQueue, updatedTransactions transactionStack: [SKPaymentTransaction]) {
        transactionStack.forEach { transactionLine in
            switch transactionLine.transactionState {
            case .purchased, .restored:
                let productMark = transactionLine.payment.productIdentifier
                let receiptLine = transactionLine.transactionIdentifier ?? "\(productMark)-\(transactionLine.transactionDate?.timeIntervalSince1970 ?? 0)"

                guard activeLedger == productMark else {
                    queueBook.finishTransaction(transactionLine)
                    return
                }

                guard markShelf.contains(receiptLine) == false else {
                    activeLedger = nil
                    queueBook.finishTransaction(transactionLine)
                    return
                }

                if let noteBundle = bundleBook[productMark] {
                    markShelf.insert(receiptLine)
                    UserDefaults.standard.set(Array(markShelf), forKey: receiptMark)
                    resultBeat?(.done(noteBundle.sparkCount))
                    pauseUntil = Date().addingTimeInterval(1.2)
                } else {
                    resultBeat?(.failed("購入情報を確認できません"))
                }
                activeLedger = nil
                queueBook.finishTransaction(transactionLine)
            case .failed:
                let errorBook = transactionLine.error as? SKError
                if errorBook?.code != .paymentCancelled {
                    resultBeat?(.failed("購入に失敗しました"))
                } else {
                    resultBeat?(.failed("購入をキャンセルしました"))
                }
                activeLedger = nil
                queueBook.finishTransaction(transactionLine)
            case .deferred:
                resultBeat?(.failed("承認待ちです"))
            case .purchasing:
                break
            @unknown default:
                resultBeat?(.failed("購入を確認できません"))
                queueBook.finishTransaction(transactionLine)
            }
        }
    }
}
