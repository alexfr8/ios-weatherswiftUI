import Foundation

enum APIError: LocalizedError {
    case auth
    case requestError(message: String)
    case client
    case server
    case connection
    case noData
    case unknown
    case badURL
    case tooMuchAttemps
    case sessionExpired

    static func fromStatusCode(_ code: Int) -> APIError {
        switch code {
        case 400:
            return .requestError(message: "")
        case 401, 403:
            return .auth
        case 402, 404...499:
            return .client
        case 500...599:
            return .server
        default:
            return .unknown
        }
    }

    var errorDescription: String? {
        switch self {
        case .auth:
            return String(localized: "auth_error_message")
        case .client:
            return String(localized: "client_error_message")
        case .server:
            return String(localized: "server_error_message")
        case .connection:
            return String(localized: "connection_error_message")
        case .noData:
            return String(localized: "no_data_error_message")
        case .unknown:
            return String(localized: "unknown_error")
        case .badURL:
            return String(localized: "bad_url_error_message")
        case .tooMuchAttemps:
            return String(localized: "too_much_attemps_message")
        case .sessionExpired:
            return String(localized: "error_session_expired")
        case .requestError(let message):
            return message
        }
    }

    var errorTitle: String? {
        switch self {
        case .auth:
            return String(localized: "auth_error_title")
        case .client:
            return String(localized: "client_error_title")
        case .server:
            return String(localized: "server_error_title")
        case .connection:
            return String(localized: "connection_error_title")
        case .noData:
            return String(localized: "no_data_error_title")
        case .unknown:
            return String(localized: "unknown_error")
        case .badURL:
            return String(localized: "bad_url_error_title")
        case .tooMuchAttemps:
            return String(localized: "too_much_attemps_title")
        case .sessionExpired:
            return String(localized: "error_session_expired")
        case .requestError(let message):
            return message
        }
    }
}
