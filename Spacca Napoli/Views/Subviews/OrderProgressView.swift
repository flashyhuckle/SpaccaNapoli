import SwiftUI

struct OrderProgressView: View {
    @Binding var status: OrderStatus
    
    var body: some View {
        VStack(alignment: .leading) {
            if status == .cancelled {
                CancelledOrderSubview()
            } else {
                OrderProgressSubview(status: $status, expectedStatus: .placed)
                OrderProgressSubview(status: $status, expectedStatus: .accepted)
                OrderProgressSubview(status: $status, expectedStatus: .inPreparation)
                OrderProgressSubview(status: $status, expectedStatus: .ready)
                OrderProgressSubview(status: $status, expectedStatus: .inDelivery)
                OrderProgressSubview(status: $status, expectedStatus: .delivered)
            }
        }
    }
}

#Preview {
    OrderProgressView(status: .constant(OrderStatus.placed))
}

struct OrderProgressSubview: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var satisfied: Bool = false
    @Binding var status: OrderStatus
    let expectedStatus: OrderStatus
    
    var body: some View {
        HStack {
            Image(systemName: satisfied ? "checkmark.circle" : "circle")
                .foregroundStyle(satisfied ? .green : (colorScheme == .dark ? .white : .black))
            Text(orderStatusText())
                .foregroundStyle(satisfied ? .green : .clear)
        }
        
        .onAppear {
            isSatisfied()
        }
        .onChange(of: status) {
            isSatisfied()
        }
    }
    
    private func isSatisfied() {
        let statusArray = OrderStatus.allCases
        
        switch status {
        case .placed:
            satisfied = checkArray(statusArray[0..<1], status: expectedStatus)
        case .accepted:
            satisfied = checkArray(statusArray[0...1], status: expectedStatus)
        case .inPreparation:
            satisfied = checkArray(statusArray[0...2], status: expectedStatus)
        case .ready:
            satisfied = checkArray(statusArray[0...3], status: expectedStatus)
        case .inDelivery:
            satisfied = checkArray(statusArray[0...4], status: expectedStatus)
        case .delivered:
            satisfied = checkArray(statusArray[0...5], status: expectedStatus)
        case .cancelled:
            satisfied = false
        }
    }
    
    private func checkArray(_ array: ArraySlice<OrderStatus>, status: OrderStatus) -> Bool {
        if array.contains(where: {$0 == status}) {
            return true
        } else {
            return false
        }
    }
    
    private func orderStatusText() -> String {
        switch expectedStatus {
            case .placed: "Order has been placed"
            case .accepted: "Restaurant accepted your order"
            case .inPreparation: "Restaurant is preparing your order"
            case .ready: "Order is waiting for delivery"
            case .inDelivery: "Your order is on the way"
            case .delivered: "Your order is delivered"
            case .cancelled: "Your order has been cancelled"
        }
    }
}

struct CancelledOrderSubview: View {
    var body: some View {
        HStack {
            Image(systemName: "x.circle")
            Text("Your order has been cancelled")
        }
        .foregroundStyle(.red)
    }
}
