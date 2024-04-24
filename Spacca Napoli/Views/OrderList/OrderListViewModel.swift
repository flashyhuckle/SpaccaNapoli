import Foundation

final class OrderListViewModel: ObservableObject {
    private let communicator: OrderCommunicatorType
    @Published var orders = [Order]()
    @Published var isFirstLoading = true
    
    init(
        communicator: OrderCommunicatorType = OrderCommunicator()
    ) {
        self.communicator = communicator
    }
    
    func onAppear() {
        loadOrders()
    }
    
    func refresh() {
        loadOrders()
    }
    
    private func loadOrders() {
        Task { @MainActor in
            orders = try await communicator.loadOrders().sorted(by: {$0.placedDate > $1.placedDate})
            isFirstLoading = false
        }
    }
}
