import Foundation

final class ReserveViewModel: ObservableObject {
    private let communicator: DataCommunicatorType
    @Published private var name: String = ""
    @Published private var email: String = ""
    @Published private var phone: String = ""
    
    @Published private var restaurant: RestaurantLocation = .swietokrzyska
    @Published private var numberOfPeople = 0
    
    @Published private var day: Date = .tomorrow
    @Published private var hour: Date = .tomorrow
    
    @Published private var isAlertShowing = false
    
    init(
        communicator: DataCommunicatorType = DataCommunicator()
    ) {
        self.communicator = communicator
    }
    
    private func hourRange() -> ClosedRange<Date> {
        let min = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: .tomorrow)!
        let max = Calendar.current.date(bySettingHour: 21, minute: 30, second: 0, of: .tomorrow)!
        return min...max
    }
    
    private func createDate() -> Date {
        var dayComponents = Calendar.current.dateComponents([.day, .month, .year], from: day)
        let hourComponents = Calendar.current.dateComponents([.hour, .minute], from: hour)
        dayComponents.hour = hourComponents.hour
        dayComponents.minute = hourComponents.minute
        guard let date = Calendar.current.date(from: dayComponents) else { return Date() }
        return date
    }
    
    private func reserveTable() {
        let reservation = Reservation(
            id: UUID(),
            name: name,
            email: email,
            phone: phone,
            numberOfPeople: numberOfPeople + 1,
            date: createDate(),
            status: .placed,
            restaurant: restaurant
        )
        Task {
            try await communicator.place(reservation)
        }
    }
    
    func alertMessage() -> String {
        "Your reservation for \(createDate()) for \(numberOfPeople + 1) has been requested. Please wait for a confirmation."
    }
}
