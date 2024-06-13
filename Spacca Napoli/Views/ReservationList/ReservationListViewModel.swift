import Foundation

final class ReservationListViewModel: ObservableObject {
    private let communicator: ReservationCommunicatorType
    @Published var reservations = [Reservation]()
    
    init(
        communicator: ReservationCommunicatorType = ReservationCommunicator()
    ) {
        self.communicator = communicator
    }
    
    func onAppear() async {
        await getReservations()
    }
    
    func refresh() async {
        await getReservations()
    }
    
    func upcomingReservations() -> [Reservation] {
        reservations.filter({$0.date > Date.now})
    }
    
    func pastReservations() -> [Reservation] {
        reservations.filter({$0.date < Date.now})
    }
    
    private func getReservations() async {
        do {
            reservations = try await communicator.loadReservations().sorted(by: {$0.date > $1.date})
        } catch {
            
        }
    }
}
