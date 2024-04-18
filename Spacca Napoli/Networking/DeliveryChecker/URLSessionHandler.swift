import Foundation

protocol URLSessionHandlerType {
    func performRequest(query: [String:String]?) async throws -> Data
}

final class URLSessionHandler: URLSessionHandlerType {
    private let baseURL: URL
    private let session: URLSession
    
    init(
        baseURL: URL = Bundle.main.apiBaseUrl,
        session: URLSession = URLSession(
            configuration: .default
        )
    ) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func performRequest(query: [String:String]? = nil) async throws -> Data {
        var url = baseURL
        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let query {
                components.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
            }
            
            if let resultUrl = components.url {
                url = resultUrl
            } else {
                throw RequestError.cannotBuildURL
            }
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.badResponse
        }
        
        switch response.statusCode {
        case 401:
            throw RequestError.unauthorized
        case 400..<500:
            throw RequestError.clientError(statusCode: response.statusCode)
        case 500...:
            throw RequestError.serverError(statusCode: response.statusCode)
        default:
            break
        }
        
        return data
    }
}
