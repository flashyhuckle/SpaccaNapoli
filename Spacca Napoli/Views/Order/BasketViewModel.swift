import Foundation
import SwiftUI

final class BasketViewModel: ObservableObject {
    @Binding var basket: Basket
    
    init(
        basket: Binding<Basket>
    ) {
        _basket = basket
    }
    
    func onDelete(_ indexSet: IndexSet) {
        basket.items.remove(atOffsets: indexSet)
    }
    
    func buttonText() -> String {
        var price = 0
        for item in basket.items {
            price += item.price
        }
        return "Basket: \(price) PLN"
    }
}
