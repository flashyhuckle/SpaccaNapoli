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
            isPhoneValid = !phone.isValidPhoneNumber
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
    
    func dateRange() -> PartialRangeFrom<Date> {
        Date.tomorrow...
    }
    
    func createDate() -> Date {
        var dayComponents = Calendar.current.dateComponents([.day, .month, .year], from: day)
        let hourComponents = Calendar.current.dateComponents([.hour, .minute], from: hour)
        dayComponents.hour = hourComponents.hour
        dayComponents.minute = hourComponents.minute
        guard let date = Calendar.current.date(from: dayComponents) else { return Date() }
        return date
    }
    
    func reserveButtonPressed() {
        if allFieldsValid() {
            reserveTable()
        } else {
            isAlertShowing = true
        }
    }
    
    func allFieldsValid() -> Bool {
        guard isNameValid, isEmailValid, isPhoneValid else { return false }
        return true
    }
    
    func reserveTable() {
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
        isAlertShowing = true
    }
    
    func alertTitle() -> String {
        if allFieldsValid() {
            "Your request is sent"
        } else {
            "Cannot process your request"
        }
    }
    
    func alertMessage() -> String {
        if allFieldsValid() {
            "Your reservation for \(createDate().formatted()) for \(numberOfPeople + 1) has been requested. Please wait for a confirmation."
        } else {
            "Please check your data, something's not right."
        }
    }
}
