import XCTest

@testable import Spacca_Napoli

final class BasketViewModelTests: XCTestCase {
    
    func testOnAppear() {
        let vm = BasketViewModel(basket: .constant(Basket(items: Order.mockOrder().orderedItems)))
        
    }
}
