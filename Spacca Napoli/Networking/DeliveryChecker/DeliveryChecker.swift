import Foundation

final class DeliveryChecker: DeliveryCheckerType {
    private let api = ApiCaller()
    
    func check(_ address: Address) async throws -> DeliveryOption {
        let coordinates = try await api.getCoordinates(for: address)
        let distance = DistanceCalculator.calculateDistance(from: coordinates)
        switch distance {
        case ..<2000:
            return .free
        case ..<10000:
            return .paid
        default:
            return .notPossible
        }
    }
}
