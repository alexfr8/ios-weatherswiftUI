import Foundation

protocol LocalStorageProtocol: Actor {
    func getFirstTimeRun() -> Bool
    func setFirstTimeRun(_ isFirstTime: Bool)
    func getApiKey() -> String
    func setApiKey(_ apiKey: String)
    func cleanAll() async
}

actor LocalStorageClient: LocalStorageProtocol {
    private enum UserDefaultKeys: String {
        case firstTime
    }

    init() {}

    func getFirstTimeRun() -> Bool {
        UserDefaults.standard.firstRun
    }

    func setFirstTimeRun(_ isFirstTime: Bool) {
        UserDefaults.standard.firstRun = isFirstTime
    }

    func getApiKey() -> String {
        UserDefaults.standard.apiKey
    }

    func setApiKey(_ apiKey: String) {
        UserDefaults.standard.apiKey = apiKey
    }

    // MARK: - Clean

    func cleanAll() async {
        UserDefaults.standard.cleanAll()
    }
}
