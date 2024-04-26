import Foundation
import SwiftUI

final class BasketViewModel: ObservableObject {
    @Binding var basket: Basket
    @Published var orderPossible = false
    @Published var alertShowing = false
    
    init(
        basket: Binding<Basket>
    ) {
        _basket = basket
    }
    
    func onAppear() {
        checkBasket()
    }
    
    func onDelete(_ indexSet: IndexSet) {
        basket.items.remove(atOffsets: indexSet)
        checkBasket()
    }
    
    func buttonText() -> String {
        var price = 0
        for item in basket.items {
            price += item.price
        }
        return "Checkout: \(price) PLN"
    }
    
    func checkBasket() {
        if basket.items.count > 1 {
            orderPossible = true
        } else {
            orderPossible = false
        }
    }
    
    func buttonPressed() {
        alertShowing = true
    }
}
