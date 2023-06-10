import SwiftUI
import SwiftData

@main
struct BmtcMateApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
