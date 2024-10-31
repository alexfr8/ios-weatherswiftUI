import Foundation
import SwiftUI

extension Screen: View {
    var body: some View {
        switch self {
        case .root:
            RootScreen()
        case .splash:
            SplashScreen()
        case .onboarding:
            OnboardingScreen()
        case .home:
            HomeScreen()

        }
    }
}
