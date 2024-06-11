import SwiftUI

class AddressTextfieldViewModel: ObservableObject {
    enum ButtonState {
        case unchecked, possible, notPossible
    }
    
    @Binding var address: Address {
        didSet {
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
            AddressButtonText.unchecked
        case .possible:
            AddressButtonText.possible
        case .notPossible:
            AddressButtonText.notPossible
        }
    }
    
    func getAlertTitle() -> String {
        switch deliveryPossible {
        case .free:
            return AddressAlertTitle.free
        case .paid:
            return AddressAlertTitle.paid
        case .notPossible:
            return AddressAlertTitle.notPossible
        }
    }
    
    func getAlertMessage() -> String {
        switch deliveryPossible {
        case .free:
            return AddressAlertMessage.free
        case .paid:
            return AddressAlertMessage.paid
        case .notPossible:
            return AddressAlertMessage.notPossible
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
    
    func checkAddress() async {
        do {
            deliveryPossible = try await deliveryChecker.check(address)
            processDelivery()
        } catch {
            
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
