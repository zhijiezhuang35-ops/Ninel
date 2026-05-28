import SwiftUI

@main
struct ninelApp: App {
    init() {
        MurmurArchive.sharedArchive.preludePage()
        ThreadWeave.sharedLedger.weavePrelude()
    }

    var body: some Scene {
        WindowGroup {
            ThreadRoot()
        }
    }
}
