import Foundation

final class ReservationListViewModel: ObservableObject {
    private let communicator: DataCommunicatorType
    @Published var reservations = [Reservation]()
    
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
        Task { @MainActor in
            reservations = try await communicator.loadReservations()
        }
    }
}
