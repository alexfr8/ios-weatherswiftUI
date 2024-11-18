import Foundation
import SwiftUI

protocol AppStateProtocol: Sendable {
    var api: APIServicesProtocol { get }
    var repository: RepositoryProtocol { get }
    var navigation: NavigationState { get }

    var openWeatherClient: OpenWeatherClient { get }
}

final class AppState: AppStateProtocol {
    let api: APIServicesProtocol
    let repository: RepositoryProtocol
    let navigation: NavigationState


    init(api: APIServicesProtocol, navigation: NavigationState, repository: any RepositoryProtocol) {
        self.api = api
        self.navigation = navigation
        self.repository = repository
    }
}

// MARK: - Clients

extension AppState {
    var openWeatherClient: OpenWeatherClient {
        OpenWeatherClient(network: api, repository: repository)
    }
}
