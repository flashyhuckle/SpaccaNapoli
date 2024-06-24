import Foundation
import Firebase

protocol FirebaseHandlerType {
    func placeOrder(_ order: Order) async throws
    func loadOrders() async throws -> [Order]
    func refreshOrder(_ order: Order) async throws -> Order
    
    func observeOrder(_ order: Order, onReceive: @escaping ((Order) -> Void))
    func stopObservingOrder()
    
    func placeReservation(_ reservation: Reservation) async throws
    func loadReservations() async throws -> [Reservation]
    
    func loadMenu() async throws -> Menu
    
    func observeDelivery(_ order: Order, onReceive: @escaping ((Delivery) -> Void))
    func stopObservingDelivery()
}

final class FirebaseHandler: FirebaseHandlerType {
    private let db = Firestore.firestore()
    
    private let orderCollection = "Orders"
    private let orderKey = "Order"
    
    private let reservationCollection = "Reservations"
    private let reservationKey = "Reservation"
    
    private let menuCollection = "Menu"
    private let menuKey = "Menu"
    
    private let deliveryCollection = "Delivery"
    private let deliveryKey = "Delivery"
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    static let shared = FirebaseHandler()
    private init() {}
    
    var orderListener: (any ListenerRegistration)?
    var deliveryListener: (any ListenerRegistration)?
}

//Order handling
extension FirebaseHandler {
    
    func placeOrder(_ order: Order) async throws {
        do {
            let encoded = try encoder.encode(order)
            try await db.collection(orderCollection).document(order.id.uuidString).setData([orderKey: encoded])
        } catch {
            throw FirebaseError.cantPlaceOrder
        }
    }
    
    func loadOrders() async throws -> [Order] {
        do {
            let query = try await db.collection(orderCollection).getDocuments()
            let documents = query.documents
            var orders = [Order]()
            for document in documents {
                let decoded = try decoder.decode(Order.self, from: document.data()[orderKey] as! Data)
                orders.append(decoded)
            }
            return orders
        } catch {
            throw FirebaseError.cantLoadOrders
        }
    }
    
    #warning("nested error?")
    func refreshOrder(_ order: Order) async throws -> Order {
        let docRef = db.collection(orderCollection).document(order.id.uuidString)
        do {
            let document = try await docRef.getDocument()
            if document.exists {
                let decoded = try decoder.decode(Order.self, from: document.data()![orderKey] as! Data)
                return decoded
            } else {
                throw FirebaseError.cantLoadOrder
            }
        } catch {
            throw FirebaseError.cantLoadOrder
        }
    }
    
    
    #warning("error inside closure?")
    func observeOrder(_ order: Order, onReceive: @escaping ((Order) -> Void)) {
        orderListener = db.collection(orderCollection).document(order.id.uuidString)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                guard let self = self else { return }
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                guard let decoded = try? self.decoder.decode(Order.self, from: data[self.orderKey] as! Data) else { return }
                onReceive(decoded)
            }
    }
    
    func stopObservingOrder() {
        orderListener?.remove()
    }
}

//Reservation handling
extension FirebaseHandler {
    func placeReservation(_ reservation: Reservation) async throws {
        do {
            let encoded = try encoder.encode(reservation)
            try await db.collection(reservationCollection).document(reservation.id.uuidString).setData([reservationKey: encoded])
        } catch {
            throw FirebaseError.cantPlaceReservation
        }
    }
    
    #warning("error fetching vs error decoding")
    func loadReservations() async throws -> [Reservation] {
        do {
            let query = try await db.collection(reservationCollection).getDocuments()
            let documents = query.documents
            var reservations = [Reservation]()
            for document in documents {
                let decoded = try decoder.decode(Reservation.self, from: document.data()[reservationKey] as! Data)
                reservations.append(decoded)
            }
            return reservations
        } catch {
            throw FirebaseError.cantLoadReservationList
        }
    }
}

//Menu handling
extension FirebaseHandler {
    func loadMenu() async throws -> Menu {
        let docRef = db.collection(menuCollection).document(menuKey)
        do {
            let document = try await docRef.getDocument()
            if document.exists {
                let decoded = try decoder.decode(Menu.self, from: document.data()![menuKey] as! Data)
                return decoded
            } else {
                throw FirebaseError.cantLoadMenu
            }
        } catch {
            throw error
        }
    }
}

//Delivery handling
extension FirebaseHandler {
    func observeDelivery(_ order: Order, onReceive: @escaping ((Delivery) -> Void)) {
        deliveryListener = db.collection(deliveryCollection).document(order.id.uuidString)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                guard let self = self else { return }
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                guard let decoded = try? self.decoder.decode(Delivery.self, from: data[self.deliveryKey] as! Data) else { return }
                onReceive(decoded)
            }
    }
    
    func stopObservingDelivery() {
        deliveryListener?.remove()
    }
}
