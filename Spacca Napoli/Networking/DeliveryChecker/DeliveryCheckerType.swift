import Foundation

protocol DeliveryCheckerType {
    func check(_ address: Address) async throws -> DeliveryOption
}
