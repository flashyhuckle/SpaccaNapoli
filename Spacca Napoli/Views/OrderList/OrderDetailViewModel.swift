import Foundation
import SwiftUI

final class OrderDetailViewModel: ObservableObject {
    private let communicator: OrderCommunicatorType
    @Binding var order: Order
    
    init(
        order: Binding<Order>,
        communicator: OrderCommunicatorType = OrderCommunicator()
    ) {
        _order = order
        self.communicator = communicator
    }
    
    
    func onAppear() {
        observeOrder()
    }
    
    func refresh() async {
        await refreshOrder()
    }
    
    func onDisappear() {
        stopObserving()
    }
    
    func widgetButtonPressed() {
        
    }
    
    func itemsTotal() -> Int {
        var price = 0
        for item in order.orderedItems {
            price += item.price
        }
        return price
    }
    
    func orderTotal() -> Int {
        var price = 0
        for item in order.orderedItems {
            price += item.price
        }
        price += order.deliveryCost
        return price
    }
    
    private func refreshOrder() async {
        do {
            let refreshedOrder = try await communicator.refresh(order)
                order.status = refreshedOrder.status
        } catch {
            
        }
    }
    
    private func observeOrder() {
        communicator.observe(order) { [weak self] order in
            guard let self = self else { return }
            self.order.status = order.status
        }
    }
    
    private func stopObserving() {
        communicator.stopObserving()
    }
}
