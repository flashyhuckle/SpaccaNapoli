import Foundation

final class ReservationListViewModel: ObservableObject {
    private let communicator: ReservationCommunicatorType
    @Published var reservations = [Reservation]()
    
    init(
        communicator: ReservationCommunicatorType = ReservationCommunicator()
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
