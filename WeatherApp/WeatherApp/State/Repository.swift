import Foundation

protocol RepositoryProtocol: Actor {
    func setFirstTimeRun(_ isFirstTime: Bool) async
    func getFirstTimeRun() async -> Bool
    func setApiKey(_ apikey: String) async
    func getApiKey() async -> String
    func cleanAll() async
}

actor Repository: RepositoryProtocol {
    // MARK: - Storage

    let localStorageClient: LocalStorageProtocol

    init(localStorageClient: LocalStorageProtocol) {
        self.localStorageClient = localStorageClient
    }

    func setFirstTimeRun(_ isFirstTime: Bool) async {
        await localStorageClient.setFirstTimeRun(isFirstTime)
    }

    func getFirstTimeRun() async -> Bool {
        await localStorageClient.getFirstTimeRun()
    }

    func setApiKey(_ apikey: String) async {
        await localStorageClient.setApiKey(apikey)
    }

    func getApiKey() async -> String {
        await localStorageClient.getApiKey()
    }

    func cleanAll() async {
        await localStorageClient.cleanAll()
    }
}
