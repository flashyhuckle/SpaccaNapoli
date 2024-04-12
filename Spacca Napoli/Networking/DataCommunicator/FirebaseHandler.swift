import Foundation
import Firebase

final class FirebaseHandler {
    private let db = Firestore.firestore()
    
    private let orderCollection = "Orders"
    private let orderKey = "Order"
    
    private let reservationCollection = "Reservations"
    private let reservationKey = "Reservation"
    
    static let shared = FirebaseHandler()
    private init() {}
    
    var listener: (any ListenerRegistration)?
}

//Order handling
extension FirebaseHandler {
    
    func placeOrder(_ order: Order) async throws {
        do {
            let encoded = try JSONEncoder().encode(order)
            try await db.collection(orderCollection).document(order.id.uuidString).setData([orderKey: encoded])
        } catch {
            throw error
        }
    }
    
    func loadOrders() async throws -> [Order] {
        do {
            let query = try await db.collection(orderCollection).getDocuments()
            let documents = query.documents
            var orders = [Order]()
            for document in documents {
                let data = document.data()
                let decoded = try JSONDecoder().decode(Order.self, from: data[orderKey] as! Data)
                orders.append(decoded)
            }
            return orders
        } catch {
            throw error
        }
    }
    
    func refreshOrder(_ order: Order) async throws -> Order {
        let docRef = db.collection(orderCollection).document(order.id.uuidString)
        do {
            let document = try await docRef.getDocument()
            if document.exists {
                let data = document.data()!
                let decoded = try JSONDecoder().decode(Order.self, from: data[orderKey] as! Data)
                return decoded
            } else {
                throw NetworkingError.cantLoadOrder
            }
        } catch {
            throw error
        }
    }
    
    func observeOrder(
        _ order: Order,
        onReceive: @escaping ((Order) -> Void)
    ) {
        listener = db.collection(orderCollection).document(order.id.uuidString)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                guard let decoded = try? JSONDecoder().decode(Order.self, from: data[self.orderKey] as! Data) else { return }
                onReceive(decoded)
            }
    }
    
    func stopObserving() {
        listener?.remove()
    }
}

//Reservation handling
extension FirebaseHandler {
    func placeReservation(_ reservation: Reservation) async throws {
        do {
            let encoded = try JSONEncoder().encode(reservation)
            try await db.collection(reservationCollection).document(reservation.id.uuidString).setData([reservationKey: encoded])
        } catch {
            throw error
        }
    }
    
    func loadReservations() async throws -> [Reservation] {
        do {
            let query = try await db.collection(reservationCollection).getDocuments()
            let documents = query.documents
            var reservations = [Reservation]()
            for document in documents {
                let data = document.data()
                let decoded = try JSONDecoder().decode(Reservation.self, from: data[reservationKey] as! Data)
                reservations.append(decoded)
            }
            return reservations
        } catch {
            throw error
        }
    }
}
