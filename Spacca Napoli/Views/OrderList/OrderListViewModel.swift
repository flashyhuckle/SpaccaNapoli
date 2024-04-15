import Foundation

final class OrderListViewModel: ObservableObject {
    private let communicator: DataCommunicatorType
    @Published var orders = [Order]()
    
    init(
        communicator: DataCommunicatorType = DataCommunicator()
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
            orders = try await communicator.loadOrders()
        }
    }
}
