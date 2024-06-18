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
    private let distanceCalculator: DistanceCalculatorType
    
    init(
        api: GeocodeAPIType = GeocodeAPI(),
        distanceCalculator: DistanceCalculatorType = DistanceCalculator()
    ) {
        self.api = api
        self.distanceCalculator = distanceCalculator
    }
    
    func check(_ address: Address) async throws -> DeliveryOption {
        guard let coordinates = try? await api.getCoordinates(for: address) else {
            return .notPossible
        }
        let distance = distanceCalculator.calculateDistance(from: coordinates)
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
