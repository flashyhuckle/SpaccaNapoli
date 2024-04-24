import Foundation
import SwiftUI

final class OrderViewModel: ObservableObject {
    @Binding var basket: Basket
    private let communicator: OrderCommunicatorType
    
    @Published var address = Address(
        street: "Chłodna",
        building: "51",
        apartment: "100",
        city: "Warszawa",
        postalCode: "00-867"
    )
    
    @Published var isDeliveryPossible = false
    @Published var deliveryCost = 0
    
    @Published var deliveryPossible: DeliveryOption = .notPossible
    
    @Published var isAlertVisible = false
    
    init(
        basket: Binding<Basket>,
        communicator: OrderCommunicatorType = OrderCommunicator()
    ) {
        _basket = basket
        self.communicator = communicator
    }
    
    func onAppear() {
        switch deliveryPossible {
        case .free:
            isDeliveryPossible = true
            deliveryCost = 0
        case .paid:
            isDeliveryPossible = true
            deliveryCost = 10
        case .notPossible:
            isDeliveryPossible = false
            deliveryCost = 0
        }
    }
    
    func placeOrder() {
        let order = Order(address: address, deliveryCost: deliveryCost, orderedItems: basket.items)
        Task { @MainActor in
            try await communicator.place(order)
            self.isAlertVisible = true
        }
    }
    
    func alertActionButtonPressed() {
        basket.items.removeAll()
        NavigationPopper.popToRootView()
    }
}
