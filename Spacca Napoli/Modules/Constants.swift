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
