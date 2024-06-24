import Foundation
import SwiftUI

final class OrderViewModel: ObservableObject {
    @Binding var basket: Basket
    private let communicator: OrderCommunicatorType
    
    @Published var address: Address
    
    @Published var isDeliveryPossible = false
    @Published var deliveryCost = 0
    
    @Published var deliveryPossible: DeliveryOption = .notPossible
    
    @Published var isAlertVisible = false
    
#warning("user address from defaults?")
    init(
        communicator: OrderCommunicatorType = OrderCommunicator(),
        basket: Binding<Basket>,
        address: Address = Address(
            street: "Chłodna",
            building: "51",
            apartment: "100",
            city: "Warszawa",
            postalCode: "00-867"
        )
    ) {
        _basket = basket
        self.address = address
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
    
    func buttonPressed() async {
        if isDeliveryPossible {
            await placeOrder()
        } else {
            DispatchQueue.main.async {
                self.isAlertVisible = true
            }
        }
    }
    
    func alertTitle() -> String {
        if isDeliveryPossible {
            OrderAlertTitle.orderPlaced
        } else {
            OrderAlertTitle.orderNotPossible
        }
    }
    
    func alertMessage() -> String {
        if isDeliveryPossible {
            OrderAlertMessage.orderPlaced
        } else {
            OrderAlertMessage.orderNotPossible
        }
    }
    
    private func placeOrder() async {
        let order = Order(address: address, deliveryCost: deliveryCost, orderedItems: basket.items)
        do {
            try await communicator.place(order)
            DispatchQueue.main.async {
                self.isAlertVisible = true
            }
        } catch {
            
        }
    }
    
    func alertActionButtonPressed() {
        if isDeliveryPossible {
            finishOrdering()
        }
    }
    
    private func finishOrdering() {
        DispatchQueue.main.async {
            self.basket.items.removeAll()
        }
        NavigationPopper.popToRootView()
    }
}
