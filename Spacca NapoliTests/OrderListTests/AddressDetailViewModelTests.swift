import XCTest
import SwiftUI

@testable import Spacca_Napoli

final class AddressDetailViewModelTests: XCTestCase {
    
    func testOnAppear() async {
        let api = GeocodeAPIMock()
        let vm = AddressDetailViewModel(address: Order.mockOrder().address, api: api)
        
        await vm.onAppear()
        
        XCTAssertTrue(api.getCoordinatesCalled)
    }
}
