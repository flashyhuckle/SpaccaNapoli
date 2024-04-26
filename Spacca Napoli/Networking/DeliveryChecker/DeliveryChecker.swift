import Foundation

enum DeliveryCheckerError: Error {
    case addressNotFound
}

protocol DeliveryCheckerType {
    func check(_ address: Address) async throws -> DeliveryOption
}

enum DeliveryOption {
    case free
    case paid
    case notPossible
}

final class DeliveryChecker: DeliveryCheckerType {
    private let api: GeocodeAPIType
    
    init(
        api: GeocodeAPIType = GeocodeAPI()
    ) {
        self.api = api
    }
    
    func check(_ address: Address) async throws -> DeliveryOption {
        guard let coordinates = try await api.getCoordinates(for: address) else {
            return .notPossible
            throw DeliveryCheckerError.addressNotFound
        }
        let distance = DistanceCalculator.calculateDistance(from: coordinates)
        switch distance {
        case ..<2000:
            return .free
        case ..<5000:
            return .paid
        default:
            return .notPossible
        }
    }
}
