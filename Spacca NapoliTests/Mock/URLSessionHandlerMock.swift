import Foundation
@testable import Spacca_Napoli

final class URLSessionHandlerMockData: URLSessionHandlerType {
    func performRequest(query: [String : String]?) async throws -> Data {
        GeocodeResponse.mockGeocodeData()
    }
}

final class URLSessionHandlerMockNoKey: URLSessionHandlerType {
    func performRequest(query: [String : String]?) async throws -> Data {
        throw RequestError.unauthorized
    }
}

final class URLSessionHandlerMockEmptyData: URLSessionHandlerType {
    func performRequest(query: [String : String]?) async throws -> Data {
        Data()
    }
}

final class URLSessionHandlerMockBadQuery: URLSessionHandlerType {
    func performRequest(query: [String : String]?) async throws -> Data {
        throw RequestError.cannotBuildURL
    }
}

final class URLSessionHandlerMockBadResponse: URLSessionHandlerType {
    func performRequest(query: [String : String]?) async throws -> Data {
        throw RequestError.badResponse
    }
}

final class URLSessionHandlerMockBadStatusCode: URLSessionHandlerType {
    let statusCode: Int
    
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
    
    func performRequest(query: [String : String]?) async throws -> Data {
        switch statusCode {
        case 401:
            throw RequestError.unauthorized
        case 400..<500:
            throw RequestError.clientError(statusCode: statusCode)
        case 500...:
            throw RequestError.serverError(statusCode: statusCode)
        default:
            break
        }
        
        return Data()
    }
}
