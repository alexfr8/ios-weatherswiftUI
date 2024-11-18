import Foundation

protocol APIServicesProtocol: Actor {
    func performURLRequest(for router: APIRouter) async throws -> Data
    var baseUrl: String { get }
}

actor APIServices: APIServicesProtocol {
    private let urlSession = URLSession.shared
    private let localStorageClient: LocalStorageProtocol
    let baseUrl = "https://api.openweathermap.org"

    init(localStorageClient: LocalStorageProtocol) {
        self.localStorageClient = localStorageClient
    }

    func performURLRequest(for router: APIRouter) async throws -> Data {
        if Reachability.isConnectedToNetwork() {
            let apiKey = await localStorageClient.getApiKey()
            let urlRequest = try router.createUrlRequest(withBaseURL: baseUrl, apiKey: apiKey)
            /// check if the url is valid
            guard urlRequest.url != nil else {
                throw APIError.badURL
            }
       
            return try await makeRequest(urlRequest: urlRequest, attemps: router.attempsToTry)

        } else {
            throw APIError.connection
        }
    }

    private func makeRequest(urlRequest: URLRequest, attemps: Int) async throws -> Data {
        if attemps > 0 {
            let (data, response) = try await urlSession.data(for: urlRequest)

            /// check if response has data
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.noData
            }

            /// check if status code of response is 200
            guard httpResponse.statusCode == 200 else {
                let error = APIError.fromStatusCode(httpResponse.statusCode)
                switch error {
                case .requestError:
                    let decodedData = try JSONDecoder().decode(RequestErrorData.self, from: data)
                    throw APIError.requestError(message: decodedData.error.message)
                case .server, .connection, .unknown:
                    return try await makeRequest(urlRequest: urlRequest, attemps: attemps - 1)
                default:
                    throw error
                }
            }
            return data
        }
        throw APIError.tooMuchAttemps
    }
}
