import Foundation
import Firebase

final class FirebaseHandler {
    private let db = Firestore.firestore()
    private let orderCollection = "Orders"
    private let orderKey = "Order"
    
    static let shared = FirebaseHandler()
    private init() {}
    
    func placeOrder(_ order: Order) async throws {
        do {
            let encoded = try JSONEncoder().encode(order)
            try await db.collection(orderCollection).document(order.id.string()).setData([orderKey: encoded])
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
}
