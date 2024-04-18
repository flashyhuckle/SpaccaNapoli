import Foundation

enum ApiError: Error {
    case noData
}

enum RequestError: Error {
    case cannotBuildURL
    case badResponse
    case unauthorized
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
}

enum DecodeError: Error {
    case cannotDecodeData
}
