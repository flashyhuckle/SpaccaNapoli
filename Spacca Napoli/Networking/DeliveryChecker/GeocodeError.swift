import Foundation

enum RequestError: Error, Equatable {
    case cannotBuildURL
    case badResponse
    case unauthorized
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
}

enum DecodeError: Error, Equatable {
    case cannotDecodeData
}
