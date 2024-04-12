import Foundation
import SwiftUI

final class OrderViewModel: ObservableObject {
    
    @Binding var basketItems: [MenuItem]
    
    private let deliveryChecker: DeliveryCheckerType
    private let dataCommunicator: DataCommunicatorType
    
    @Published var address = Address(
        street: "Chłodna",
        building: "51",
        apartment: "100",
        city: "Warszawa",
        postalCode: "00-867"
    ) {
        didSet {
            //'if' is required due to possible bug in @Published var didset - otherwise it gets called twice
            if address != oldValue {
                onChangeAddress()
            }
        }
    }
    
    @Published var isDeliveryPossible = false
    @Published var deliveryCost = 0
    @Published var buttonState = ButtonState.unchecked
    
    @Published var isAlertVisible = false
    
    init(
        basketItems: Binding<[MenuItem]>,
        deliveryChecker: DeliveryCheckerType = DeliveryChecker(),
        dataCommunicator: DataCommunicatorType = DataCommunicator()
    ) {
        _basketItems = basketItems
        self.deliveryChecker = deliveryChecker
        self.dataCommunicator = dataCommunicator
    }
    
    private func onChangeAddress() {
        isDeliveryPossible = false
        deliveryCost = 0
        buttonState = .unchecked
        print("onChangeAddress")
    }
    
    private func countPrice() -> Int {
        var price = deliveryCost
        for item in basketItems {
            price += item.price
        }
        return price
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
        Task {
            let deliveryOption = try await deliveryChecker.check(address)
            switch deliveryOption {
            case .free:
                isDeliveryPossible = true
                buttonState = .possible
            case .paid:
                isDeliveryPossible = true
                deliveryCost = 10
                buttonState = .possible
            case .notPossible:
                isDeliveryPossible = false
                buttonState = .notPossible
            }
        }
        
        //Old code
        
//        Task {
//            let coordinates = try await ApiCaller().getCoordinates(for: address)
//            let distance = DistanceCalculator.calculateDistance(from: coordinates).rounded()
//            print(distance)
//            if distance < 2000 {
//                isDeliveryPossible = true
//                buttonState = .possible
//            } else if distance < 10000 {
//                isDeliveryPossible = true
//                deliveryCost = 10
//                buttonState = .possible
//            } else {
//                isDeliveryPossible = false
//                buttonState = .notPossible
//            }
//        }
    }
    
    func placeOrder() {
        let order = Order(address: address, deliveryCost: deliveryCost, orderedItems: basketItems)
        Task {
            try await dataCommunicator.place(order)
            self.isAlertVisible = true
        }
        
        //Old Code
        
//        Task {
//            try await FirebaseHandler.shared.placeOrder(order)
//            self.isAlertVisible = true
//        }
    }
}
