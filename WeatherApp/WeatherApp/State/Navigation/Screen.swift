import SwiftUI

enum Screen {
    case root
    case splash
    case onboarding
    case home
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
        case .home:
            "home"
        }
    }
}
