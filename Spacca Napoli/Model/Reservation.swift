import Foundation

struct Reservation: Codable, Identifiable {
    let id: UUID
    let name: String
    let email: String
    let phone: String
    let numberOfPeople: Int
    let date: Date
    let status: ReservationStatus
    let restaurant: RestaurantLocation
}
