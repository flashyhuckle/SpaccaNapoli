import SwiftUI

class AddressTextfieldViewModel: ObservableObject {
    enum ButtonState {
        case unchecked, possible, notPossible
    }
    
    @Binding var address: Address {
        didSet {
            //'if' is required due to possible bug in @Published var didset - otherwise it gets called twice
            if address != oldValue {
                onChangeAddress()
            }
        }
    }
    @Binding var deliveryPossible: DeliveryOption
    
    @Published var buttonState = ButtonState.unchecked
    
    @Published var isAlertShowing = false
    
    private let deliveryChecker: DeliveryCheckerType
    
    init(
        address: Binding<Address>,
        deliveryPossible: Binding<DeliveryOption>,
        deliveryChecker: DeliveryCheckerType = DeliveryChecker()
    ) {
        _address = address
        _deliveryPossible = deliveryPossible
        self.deliveryChecker = deliveryChecker
    }
    
    private func onChangeAddress() {
        buttonState = .unchecked
        deliveryPossible = .notPossible
    }
    
    func onAppear() {
        switch deliveryPossible {
        case .free:
            buttonState = .possible
        case .paid:
            buttonState = .possible
        case .notPossible:
            buttonState = .unchecked
        }
    }
    
    func getButtonText() -> String {
        switch buttonState {
        case .unchecked:
            "Check address"
        case .possible:
            "Delivery possible"
        case .notPossible:
            "Delivery not possible"
        }
    }
    
    func getAlertTitle() -> String {
        switch deliveryPossible {
        case .free:
            return "Delivery is possible"
        case .paid:
            return "Delivery is possible"
        case .notPossible:
            return "Delivery is not possible"
        }
    }
    
    func getAlertMessage() -> String {
        switch deliveryPossible {
        case .free:
            return "You are close enought for free delivery"
        case .paid:
            return "You can finish your order now"
        case .notPossible:
            return "Address is incorrect or you are too far away"
        }
    }
    
    func getButtonColor() -> Color {
        switch buttonState {
        case .unchecked:
            Color(red: 0, green: 0.4, blue: 0.8)
        case .possible:
            Color(red: 0, green: 0.8, blue: 0.4)
        case .notPossible:
            Color(red: 0.8, green: 0.0, blue: 0.2)
        }
    }
    
    func checkAddress() {
        Task { @MainActor in
            deliveryPossible = try await deliveryChecker.check(address)
            processDelivery()
        }
    }
    
    func processDelivery() {
        switch deliveryPossible {
        case .free, .paid:
            buttonState = .possible
            isAlertShowing = true
        case .notPossible:
            buttonState = .notPossible
        }
    }
}
