import Foundation
@testable import Spacca_Napoli

final class DeliveryCheckerMockNoAddress: DeliveryCheckerType {
    func check(_ address: Address) async throws -> DeliveryOption {
        .notPossible
    }
}

final class DeliveryCheckerMockFree: DeliveryCheckerType {
    func check(_ address: Address) async throws -> DeliveryOption {
        .free
    }
}

final class DeliveryCheckerMockPaid: DeliveryCheckerType {
    func check(_ address: Address) async throws -> DeliveryOption {
        .paid
    }
}

final class DeliveryCheckerMockNotPossible: DeliveryCheckerType {
    func check(_ address: Address) async throws -> DeliveryOption {
        .notPossible
    }
}
