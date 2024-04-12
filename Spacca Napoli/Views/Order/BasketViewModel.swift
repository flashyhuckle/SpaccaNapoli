import Foundation
import SwiftUI

final class BasketViewModel: ObservableObject {
    @Binding var basketItems: [MenuItem]
    
    init(
        basketItems: Binding<[MenuItem]>
    ) {
        _basketItems = basketItems
    }
    
    func onDelete(_ indexSet: IndexSet) {
        basketItems.remove(atOffsets: indexSet)
    }
    
    func buttonText() -> String {
        var price = 0
        for item in basketItems {
            price += item.price
        }
        return "Basket: \(price) PLN"
    }
}
