import Foundation
import SwiftUI

final class OrderDetailViewModel: ObservableObject {
    private let communicator: DataCommunicatorType
    @Binding var order: Order
    
    init(
        order: Binding<Order>,
        communicator: DataCommunicatorType = DataCommunicator()
    ) {
        _order = order
        self.communicator = communicator
    }
    
    
    func onAppear() {
        observeOrder()
    }
    
    func refresh() {
        refreshOrder()
    }
    
    func onDisappear() {
        stopObserving()
    }
    
    private func refreshOrder() {
        Task { @MainActor in
            let refreshedOrder = try await communicator.refresh(order)
            order.status = refreshedOrder.status
        }
    }
    
    private func observeOrder() {
        communicator.observe(order) { order in
            self.order.status = order.status
        }
    }
    
    private func stopObserving() {
        communicator.stopObserving()
    }
}
