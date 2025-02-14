import Foundation

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case firstRun
        case apiKey
        case cityList
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

    var cityList: Data {
        get {
            UserDefaults.standard.data(forKey: UserDefaultKeys.cityList.rawValue) ?? Data()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeys.cityList.rawValue)
        }
    }

    func cleanAll() {
        firstRun = false
        apiKey = ""
    }
}
