import Foundation

final class ReservationListViewModel: ObservableObject {
    private let communicator: DataCommunicatorType
    @Published private var reservations = [Reservation]()
    
    init(
        communicator: DataCommunicatorType = DataCommunicator()
    ) {
        self.communicator = communicator
    }
    
    func onAppear() {
        getReservations()
    }
    
    func refresh() {
        getReservations()
    }
    
    private func getReservations() {
        Task {
            reservations = try await communicator.loadReservations()
        }
    }
}
