import Foundation

protocol RepositoryProtocol: Actor {
    func setFirstTimeRun(_ isFirstTime: Bool) async
    func getFirstTimeRun() async -> Bool
    func setApiKey(_ apikey: String) async
    func getApiKey() async -> String
    func setCities(cities: [CityDomain]) async
    func getCities() async -> [CityDomain]
    func deleteCity(withName: String) async
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

    func setCities(cities: [CityDomain]) async {
        do {
            let json = try JSONEncoder().encode(cities)
            await localStorageClient.setCities(cities: json)
        } catch {
            print("error encoding cities")
        }
    }

    func getCities() async -> [CityDomain] {
        let citiesJson = await localStorageClient.getCities()
        do {
            return try JSONDecoder().decode([CityDomain].self, from: citiesJson)
        } catch {
            print("error decoding cities")
            return []
        }
    }

    func deleteCity(withName: String) async {
        await setCities(cities: getCities().filter { city in
            city.name != withName
        })
    }

    func cleanAll() async {
        await localStorageClient.cleanAll()
    }
}
