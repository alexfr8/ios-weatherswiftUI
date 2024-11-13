import Foundation

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case firstRun
        case apiKey
    }

    var firstRun: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultKeys.firstRun.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.firstRun.rawValue)
        }
    }

    var apiKey: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultKeys.apiKey.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.apiKey.rawValue)
        }
    }

    func cleanAll() {
        firstRun = false
        apiKey = ""
    }
}
