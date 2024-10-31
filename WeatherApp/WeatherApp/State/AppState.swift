import Foundation
import SwiftUI

protocol AppStateProtocol: Sendable {
    var navigation: NavigationState { get }
}

final class AppState: AppStateProtocol {
    let navigation: NavigationState

    init(navigation: NavigationState) {
        self.navigation = navigation
    }
}
