import Foundation
import SwiftUI

struct AppStateKey: EnvironmentKey {
    static let defaultValue: AppStateProtocol = AppState(
        api: APIServices(localStorageClient: LocalStorageClient()), navigation: NavigationState(),
        repository: Repository(localStorageClient: LocalStorageClient())
    )
}

extension EnvironmentValues {
    var app: AppStateProtocol {
        get { self[AppStateKey.self] }
        set { self[AppStateKey.self] = newValue }
    }
}
