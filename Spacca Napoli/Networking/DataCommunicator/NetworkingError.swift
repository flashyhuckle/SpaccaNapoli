import Foundation

enum NetworkingError: Error {
    case cantLoadMenu
    case cantLoadOrder
    case cantLoadOrders
    case cantPlaceOrder
}

enum ReservationError: Error {
    case cantPlace
    case cantLoad
    case cantLoadList
}



