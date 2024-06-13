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
    
    func onAppear() async {
        await loadOrders()
    }
    
    func refresh() async {
        await loadOrders()
    }
    
    private func loadOrders() async {
        do {
            orders = try await communicator.loadOrders().sorted(by: {$0.placedDate > $1.placedDate})
            isFirstLoading = false
        } catch {
            
        }
    }
}
