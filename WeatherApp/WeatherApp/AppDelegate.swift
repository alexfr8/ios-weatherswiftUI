import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    let app: AppState

    override init() {
        let localStorageClient = LocalStorageClient()
        app = AppState(
            navigation: NavigationState(),
            repository: Repository(localStorageClient: localStorageClient)
        )
        super.init()
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }
}
