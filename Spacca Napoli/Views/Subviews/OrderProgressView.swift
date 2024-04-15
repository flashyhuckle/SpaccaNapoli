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
                OrderProgressSubview(status: $status, expectedStatus: .inDelivery)
                OrderProgressSubview(status: $status, expectedStatus: .delivered)
            }
        }
    }
}

#Preview {
    OrderProgressView(status: .constant(OrderStatus.inDelivery))
}

struct OrderProgressSubview: View {
    @State private var satisfied: Bool = false
    @Binding var status: OrderStatus
    let expectedStatus: OrderStatus
    
    var body: some View {
        HStack {
            Image(systemName: satisfied ? "checkmark.circle" : "circle")
            Text(getTitle())
        }
        .foregroundStyle(satisfied ? .green : .black)
        
        .onAppear {
            isSatisfied()
        }
        .onChange(of: status) {
            isSatisfied()
        }
    }
    
    private func getTitle() -> String {
        switch expectedStatus {
        case .placed:
            "Your order has been placed"
        case .accepted:
            "Your order has been accepted"
        case .inPreparation:
            "We are preparing your order"
        case .inDelivery:
            "Your order is on the way"
        case .delivered:
            "Delivery completed"
        case .cancelled:
            "Your order was cancelled"
        }
    }
    
    private func isSatisfied() {
        switch status {
        case .placed:
            if expectedStatus == .placed {
                satisfied = true
            } else {
                satisfied = false
            }
        case .accepted:
            if expectedStatus == .placed || expectedStatus == .accepted {
                satisfied = true
            } else {
                satisfied = false
            }
        case .inPreparation:
            if expectedStatus == .placed || expectedStatus == .accepted || expectedStatus == .inPreparation {
                satisfied = true
            } else {
                satisfied = false
            }
        case .inDelivery:
            if expectedStatus == .placed || expectedStatus == .accepted || expectedStatus == .inPreparation || expectedStatus == .inDelivery {
                satisfied = true
            } else {
                satisfied = false
            }
        case .delivered:
            if expectedStatus == .placed || expectedStatus == .accepted || expectedStatus == .inPreparation || expectedStatus == .inDelivery || expectedStatus == .delivered {
                satisfied = true
            } else {
                satisfied = false
            }
        case .cancelled:
            return
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
