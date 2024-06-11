import Foundation

struct Constants {
    static let spaccaLatitude = 52.234924305828386
    static let spaccaLongitude = 21.0055726745955
}

enum ReservationAlertTitle {
    static let requestSent = "Your request is sent"
    static let cannotProcess = "Cannot process your request"
}

enum ReservationAlertMessage {
    static func requestSent(date: Date, people: Int) -> String {
        "Your reservation for \(date.formatted()) for \(people) has been requested. Please wait for a confirmation."
    }
    static let badData = "Please check your data, something's not right."
}

enum OrderAlertTitle {
    static let orderPlaced = "Your order has been placed!"
    static let orderNotPossible = "Delivery is not possible"
}

enum OrderAlertMessage {
    static let orderPlaced = "You can observe it's status on order list"
    static let orderNotPossible = "Make sure your address is correct and verified"
}

enum AddressButtonText {
    static let unchecked = "Check address"
    static let possible = "Delivery possible"
    static let notPossible = "Delivery not possible"
}

enum AddressAlertTitle {
    static let free = "Delivery is possible"
    static let paid = "Delivery is possible"
    static let notPossible = "Delivery is not possible"
}

enum AddressAlertMessage {
    static let free = "You are close enought for free delivery"
    static let paid = "You can finish your order now"
    static let notPossible = "Address is incorrect or you are too far away"
}
