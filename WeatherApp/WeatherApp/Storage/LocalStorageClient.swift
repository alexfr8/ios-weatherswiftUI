import Foundation

protocol LocalStorageProtocol: Actor {
    func getFirstTimeRun() -> Bool
    func setFirstTimeRun(_ isFirstTime: Bool)
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

    // MARK: - Clean

    func cleanAll() async {
        setFirstTimeRun(false)
    }
}
