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
            let deliveryOption = try await deliveryChecker.check(address)
            deliveryPossible = deliveryOption
            switch deliveryOption {
            case .free, .paid:
                buttonState = .possible
            case .notPossible:
                buttonState = .notPossible
            }
        }
    }
}
