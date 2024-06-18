import Foundation
@testable import Spacca_Napoli

final class DistanceCalculatorMockFree: DistanceCalculatorType {
    func calculateDistance(from location: Spacca_Napoli.GeocodeResponse) -> Double {
        1500
    }
}

final class DistanceCalculatorMockPaid: DistanceCalculatorType {
    func calculateDistance(from location: Spacca_Napoli.GeocodeResponse) -> Double {
        3000
    }
}

final class DistanceCalculatorMockNotPossible: DistanceCalculatorType {
    func calculateDistance(from location: Spacca_Napoli.GeocodeResponse) -> Double {
        8000
    }
}
