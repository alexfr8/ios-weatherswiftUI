import SwiftUI

@main
struct WeatherAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    var body: some Scene {
        WindowGroup {
            RootScreen()
            .environment(\.app, appDelegate.app)
        }
    }
}
