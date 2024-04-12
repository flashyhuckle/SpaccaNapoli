import Foundation
import SwiftUI

final class OrderDetailViewModel: ObservableObject {
    @Binding var order: Order
    private let communicator: DataCommunicatorType
    
    init(
        order: Binding<Order>,
        communicator: DataCommunicatorType = DataCommunicator()
    ) {
        _order = order
        self.communicator = communicator
    }
    
    func onAppear() {
        requestNotifications()
        
        //refresh?
        refreshOrder()
        
        observeOrder()
    }
    
    func refresh() {
        refreshOrder()
    }
    
    func onDisappear() {
        stopObserving()
    }
    
    private func refreshOrder() {
        Task {
            let refreshedOrder = try await communicator.refresh(order)
            self.order.status = refreshedOrder.status
        }
        //Old
        
//        Task {
//            let refreshedOrder = try await FirebaseHandler.shared.refreshOrder(order)
//            self.order.status = refreshedOrder.status
//        }
    }
    
    private func observeOrder() {
        Task {
            communicator.observe(order) { order in
                self.order.status = order.status
            }
        }
        //Old
        
//        Task {
//            FirebaseHandler.shared.observeOrder(order) { order in
//                withAnimation {
//                    self.order.status = order.status
//                    self.displayNotification(order.status.rawValue)
//                }
//            }
//        }
    }
    private func stopObserving() {
        communicator.stopObserving()
        
//        Task {
//            FirebaseHandler.shared.stopObserving()
//        }
    }
    
    private func requestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func displayNotification(_ subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = "Order status updated"
        content.subtitle = "Your order is \(subtitle)"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)

        UNUserNotificationCenter.current().add(request)
    }
}
