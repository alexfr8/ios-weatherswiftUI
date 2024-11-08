import Foundation
import SwiftUI

protocol AppStateProtocol: Sendable {
    var repository: RepositoryProtocol { get }
    var navigation: NavigationState { get }
}

final class AppState: AppStateProtocol {
    let repository: RepositoryProtocol
    let navigation: NavigationState


    init(navigation: NavigationState, repository: any RepositoryProtocol) {
        self.navigation = navigation
        self.repository = repository
    }
}
