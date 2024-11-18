import Foundation
import OSLog

protocol APIRouter {
    /// The path for every endpoint
    var path: String { get }
    /// The headers parameters for the endpoint (in case it has any)
    var headers: [String: String] { get }
    /// The query parameters for the endpoint (in case it has any)
    var queryItems: [String: Any] { get }
    /// The body for the endpoint (in case it has any)
    var body: Data? { get }
    /// The method for the endpoint
    var httpMethod: APIMethod { get }
    /// The authentication for every endpoint
    var needsAuth: Bool { get }
    /// An alias for the cache policy.
    var cachePolicy: URLRequest.CachePolicy { get }
    /// number of attemps to try request
    var attemptsToTry: Int { get }
}

extension APIRouter {
    var queryItems: [String: Any] {
        [:]
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }

    var body: Data? {
        nil
    }

    var cachePolicy: URLRequest.CachePolicy {
        .reloadIgnoringLocalCacheData
    }

    var attempsToTry: Int {
        1
    }

    var errorDomain: String {
        "com.weatherapp.network"
    }

    private var logger: Logger {
        Logger(
            subsystem: Bundle.main.bundleIdentifier ?? "",
            category: String(describing: APIRouter.self)
        )
    }

  func createUrlRequest(withBaseURL baseURL: String, apiKey:  String) throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw APIError.badURL
        }

        if !queryItems.isEmpty {
            var parameters: [String: Any] = [:]
            queryItems.forEach { tuple in
                parameters[tuple.key] = tuple.value
            }
            parameters["appid"] = apiKey
            parameters["lang"] = "es"
            parameters["units"] = "metric"
            let queryItems = parameters.compactMap { key, value -> URLQueryItem in
                URLQueryItem(name: key, value: "\(value)")
            }
            components.queryItems = queryItems.sorted { $0.name < $1.name }
        }

        guard let url = components.url else {
            throw APIError.badURL
        }

        var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body

       // urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
       // urlRequest.setValue("application/vnd.api+json", forHTTPHeaderField: "Accept")

        if !headers.isEmpty {
            for requestHeader in headers.enumerated() {
                urlRequest.setValue("\(requestHeader.element.value)", forHTTPHeaderField: requestHeader.element.key)
            }
        }
        return urlRequest
    }

    func encodeData<T>(_ value: T) -> Data? where T: Codable {
        do {
            return try JSONEncoder().encode(value)
        } catch let error as NSError {
          debugPrint("Failed to convert into a Codable: \(value) \(error) ")
            return nil
        }
    }
}
