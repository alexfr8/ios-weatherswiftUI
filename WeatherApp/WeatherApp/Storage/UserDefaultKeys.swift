import Foundation

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case firstRun
    }

    var firstRun: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultKeys.firstRun.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.firstRun.rawValue)
        }
    }

    func cleanAll() {
        firstRun = false
    }
}
