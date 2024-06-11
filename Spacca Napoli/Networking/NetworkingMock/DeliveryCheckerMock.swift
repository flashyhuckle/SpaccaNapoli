import Foundation

final class DeliveryCheckerMock: DeliveryCheckerType {
    var result = DeliveryOption.free
    
    func check(_ address: Address) async throws -> DeliveryOption {
        result
    }
}
