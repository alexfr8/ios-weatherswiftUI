import Foundation

struct OpenWeatherClient {
    private let network: APIServicesProtocol
    private let repository: RepositoryProtocol

    init(network: APIServicesProtocol, repository: RepositoryProtocol) {
        self.network = network
        self.repository = repository
    }

    // MARK: Backend request

    func fetchToday(lat: Double, long: Double) async throws -> Today {
        let route = Routing.today(lat: lat, long: long)
        let result = try await network.performURLRequest(for: route)
        let today = try JSONDecoder().decode(Today.self, from: result)
        return today
    }

    func fetchForecast(lat: Double, long: Double) async throws -> Forecast5{
        let route = Routing.forecast5days(lat: lat, long: long)
        let result = try await network.performURLRequest(for: route)
        return try JSONDecoder().decode(Forecast5.self, from: result)
    }

    func reverseGeocoding(lat: Double, long: Double) async throws -> [Geocity] {
        let route = Routing.reverseGeocoding(lat: lat, long: long)
        let result = try await network.performURLRequest(for: route)
        return try JSONDecoder().decode([Geocity].self, from: result)
    }

    func directGeocoding(name: String) async throws -> [Geocity] {
        let route = Routing.directGeocoding(name: name)
        let result = try await network.performURLRequest(for: route)
        return try JSONDecoder().decode([Geocity].self, from: result)
    }
}

// MARK: - Routing

extension OpenWeatherClient {
    enum Routing: APIRouter {
        case today(lat: Double, long: Double)
        case forecast5days(lat: Double, long: Double)
        case reverseGeocoding(lat: Double, long: Double)
        case directGeocoding(name: String)


        var path: String {
            switch self {
            case .today:
                "/data/2.5/weather"
            case .forecast5days:
                "/data/2.5/forecast"
            case .reverseGeocoding:
                "/geo/1.0/reverse"
            case .directGeocoding:
                "/geo/1.0/direct"
            }
        }

        var httpMethod: APIMethod {
            switch self {
            case .today, .forecast5days, .reverseGeocoding, .directGeocoding:
                .get
            }
        }

        var needsAuth: Bool { true }

        var attemptsToTry: Int { 1 }

        var headers: [String: String] {
            [
                "Accept": "*/*",
                "Content-Type": "application/json"
            ]
        }
        var queryItems: [String: Any] {
            switch self {
            case let .today(lat, long):
                [
                    "lat":lat,
                    "lon": long,
                ]
            case let .forecast5days(lat, long):
                [
                    "lat":lat,
                    "lon": long,
                ]
            case let .reverseGeocoding(lat, long):
                [
                    "lat":lat,
                    "lon": long,
                    "limit": "1"
                ]
            case let .directGeocoding(name):
                [
                    "q": name,
                    "limit": "1"
                ]
            }
        }

        var body: Data? {
            switch self {
            case .today, .forecast5days, .reverseGeocoding, .directGeocoding:
                nil
            }
        }
    }
}
