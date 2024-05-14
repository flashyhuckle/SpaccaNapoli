import Foundation

final class DeliveryCheckerMock: DeliveryCheckerType {
    func check(_ address: Address) async throws -> DeliveryOption {
        .free
    }
}
