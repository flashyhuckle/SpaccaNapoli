import Foundation

struct ReservationOld: Codable, Identifiable {
    let id: UUID
    let name: String
    let email: String
    let phone: String
    let numberOfPeople: Int
    let date: Date
    let status: ReservationStatus
    let restaurant: RestaurantLocation
}

struct Reservation: Codable, Identifiable {
    let id: UUID
    let name: String
    let email: String
    let phone: String
    let numberOfPeople: Int
    let dateInt: Int
    let status: ReservationStatus
    let restaurant: RestaurantLocation
    
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(dateInt))
    }
    
    init(
        id: UUID,
        name: String,
        email: String,
        phone: String,
        numberOfPeople: Int,
        date: Date,
        status: ReservationStatus,
        restaurant: RestaurantLocation
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.numberOfPeople = numberOfPeople
        self.dateInt = Int(date.timeIntervalSince1970)
        self.status = status
        self.restaurant = restaurant
    }
}

