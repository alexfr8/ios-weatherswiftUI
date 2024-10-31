import Foundation
import Observation

@Observable
final class NavigationState: @unchecked Sendable {
    var path: [Screen] = []
    var presentingScreen: Screen?
    var presentingFullScreenCoverScreen: Screen?

    // MARK: - Push

    func push(to screens: [Screen], onDismiss: (() -> Void)? = nil) {
        path.append(contentsOf: screens)
    }

    func push(to screen: Screen, onDismiss: (() -> Void)? = nil) {
        path.append(screen)
    }

    // MARK: - Pop

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func popTo(screen: Screen) {
        guard let index = path.lastIndex(of: screen) else {
            path.removeLast()
            return
        }
        path.removeLast((path.count - 1) - index)
    }

    // MARK: - Present

    func present(to screen: Screen, onDismiss: (() -> Void)? = nil) {
        presentingScreen = screen
    }

    func presentFullScreenCover(to screen: Screen, onDismiss: (() -> Void)? = nil) {
        presentingFullScreenCoverScreen = screen
    }
}
