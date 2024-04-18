import Foundation

extension Bundle {
    public var apiKey: String {
        infoDictionary?["GeocodeApiKey"] as? String ?? ""
    }
    
    public var apiBaseUrl: URL {
        guard let baseURL = infoDictionary?["GeocodeApiBaseURL"] as? String, let url = URL(string: baseURL) else {
            fatalError("Invalid base URL")
        }
        
        return url
    }
}
