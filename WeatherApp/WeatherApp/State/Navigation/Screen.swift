import SwiftUI

enum Screen {
    case root
    case splash
    case onboarding
    case apikey
    case home
    case addCity
    case detail(weather: Today)
}

extension Screen: Hashable {
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }
}

extension Screen: Identifiable {
    var id: String {
        switch self {
        case .root:
            "root"
        case .splash:
            "splash"
        case .onboarding:
            "onboarding"
        case .apikey:
            "apikey"
        case .home:
            "home"
        case .addCity:
            "addCity"
        case .detail(weather: _):
            "detail"
        }
    }
}
