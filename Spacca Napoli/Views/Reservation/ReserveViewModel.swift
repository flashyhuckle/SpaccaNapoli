import Foundation

final class ReserveViewModel: ObservableObject {
    private let communicator: ReservationCommunicatorType
    
    @Published var name: String = "" {
        didSet {
            isNameValid = name.isValidName
        }
    }
    @Published var isNameValid: Bool = false
    
    @Published var email: String = "" {
        didSet {
            isEmailValid = email.isValidEmail
        }
    }
    @Published var isEmailValid: Bool = false
    
    @Published var phone: String = "" {
        didSet {
            isPhoneValid = phone.isValidPhoneNumber
        }
    }
    @Published var isPhoneValid: Bool = false
    
    @Published var restaurant: RestaurantLocation = .swietokrzyska
    @Published var numberOfPeople = 0
    
    @Published var day: Date = .tomorrow
    @Published var hour: Date = .tomorrow
    
    @Published var isAlertShowing = false
    
    init(
        communicator: ReservationCommunicatorType = ReservationCommunicator()
    ) {
        self.communicator = communicator
    }
    
    func hourRange() -> ClosedRange<Date> {
        let min = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: .tomorrow)!
        let max = Calendar.current.date(bySettingHour: 21, minute: 30, second: 0, of: .tomorrow)!
        return min...max
    }
    
    func dateRange() -> ClosedRange<Date> {
        let dateFrom = Date.tomorrow
        guard let dateTo = Calendar.current.date(byAdding: .month, value: 1, to: dateFrom) else {
            return dateFrom...dateFrom
        }
        return dateFrom...dateTo
    }
    
    func createDate() -> Date {
        var dayComponents = Calendar.current.dateComponents([.day, .month, .year], from: day)
        let hourComponents = Calendar.current.dateComponents([.hour, .minute], from: hour)
        dayComponents.hour = hourComponents.hour
        dayComponents.minute = hourComponents.minute
        guard let date = Calendar.current.date(from: dayComponents) else { return Date() }
        return date
    }
    
    func reserveButtonPressed() async throws {
        if allFieldsValid() {
            try await reserveTable()
        } else {
            isAlertShowing = true
        }
    }
    
    func allFieldsValid() -> Bool {
        guard isNameValid, isEmailValid, isPhoneValid else { return false }
        return true
    }
    
    func reserveTable() async throws {
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
        try await communicator.place(reservation)
        isAlertShowing = true
    }
    
    func alertTitle() -> String {
        if allFieldsValid() {
            ReservationAlertTitle.requestSent
        } else {
            ReservationAlertTitle.cannotProcess
        }
    }
    
    func alertMessage() -> String {
        if allFieldsValid() {
            ReservationAlertMessage.requestSent(date: createDate(), people: numberOfPeople + 1)
        } else {
            ReservationAlertMessage.badData
        }
    }
    
    func clearAllData() {
        #warning("clear all fields after placing reservation")
    }
}
