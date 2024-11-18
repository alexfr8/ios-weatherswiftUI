struct RequestErrorData: Codable {
    let error: ErrorData
}

struct ErrorData: Codable {
    let message: String
    let code: Int
}
