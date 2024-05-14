import Foundation

enum FirebaseError: Error, Equatable {
    case cantLoadMenu
    case cantLoadOrder
    case cantLoadOrders
    case cantPlaceOrder
    
    case cantPlaceReservation
    case cantLoadReservation
    case cantLoadReservationList
}
