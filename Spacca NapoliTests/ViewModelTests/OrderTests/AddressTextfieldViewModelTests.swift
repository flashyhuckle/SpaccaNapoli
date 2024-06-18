import XCTest
import SwiftUI

@testable import Spacca_Napoli

final class AddressTextfieldViewModelTests: XCTestCase {
    
    func testCheckAddress() async {
        let checker = DeliveryCheckerMock()
        var deliveryPossible: DeliveryOption = .free
        let binding = Binding(get: {deliveryPossible}, set: {deliveryPossible = $0})
        let vm = AddressTextfieldViewModel(
            address: .constant(Order.mockOrder().address),
            deliveryPossible: binding,
            deliveryChecker: checker
        )
        
        XCTAssertEqual(vm.buttonState, .unchecked)
        
        checker.result = .free
        await vm.checkAddress()
        
        XCTAssertTrue(vm.isAlertShowing)
        XCTAssertEqual(vm.buttonState, .possible)
        
        checker.result = .paid
        await vm.checkAddress()
        
        XCTAssertTrue(vm.isAlertShowing)
        XCTAssertEqual(vm.buttonState, .possible)
        
        checker.result = .notPossible
        await vm.checkAddress()
        
        XCTAssertEqual(vm.buttonState, .notPossible)
    }
    
    func testProcessDelivery() {
        let checker = DeliveryCheckerMock()
        var deliveryPossible: DeliveryOption = .free
        let binding = Binding(get: {deliveryPossible}, set: {deliveryPossible = $0})
        let vm = AddressTextfieldViewModel(
            address: .constant(Order.mockOrder().address),
            deliveryPossible: binding,
            deliveryChecker: checker
        )
        
        vm.deliveryPossible = .notPossible
        vm.processDelivery()
        
        XCTAssertFalse(vm.isAlertShowing)
        XCTAssertEqual(vm.buttonState, .notPossible)
        
        vm.deliveryPossible = .free
        vm.processDelivery()
        
        XCTAssertTrue(vm.isAlertShowing)
        XCTAssertEqual(vm.buttonState, .possible)
        
        vm.deliveryPossible = .paid
        vm.processDelivery()
        
        XCTAssertTrue(vm.isAlertShowing)
        XCTAssertEqual(vm.buttonState, .possible)
    }
    
    func testGetAlertMessage() {
        let checker = DeliveryCheckerMock()
        var deliveryPossible: DeliveryOption = .free
        let binding = Binding(get: {deliveryPossible}, set: {deliveryPossible = $0})
        let vm = AddressTextfieldViewModel(
            address: .constant(Order.mockOrder().address),
            deliveryPossible: binding,
            deliveryChecker: checker
        )
        
        vm.deliveryPossible = .free
        
        XCTAssertEqual(vm.getAlertMessage(), AddressAlertMessage.free)
        
        vm.deliveryPossible = .paid
        
        XCTAssertEqual(vm.getAlertMessage(), AddressAlertMessage.paid)
        
        vm.deliveryPossible = .notPossible
        
        XCTAssertEqual(vm.getAlertMessage(), AddressAlertMessage.notPossible)
    }
    
    func testGetAlertTitle() async {
        let checker = DeliveryCheckerMock()
        var deliveryPossible: DeliveryOption = .free
        let binding = Binding(get: {deliveryPossible}, set: {deliveryPossible = $0})
        let vm = AddressTextfieldViewModel(
            address: .constant(Order.mockOrder().address),
            deliveryPossible: binding,
            deliveryChecker: checker
        )
        
        vm.deliveryPossible = .free
        
        XCTAssertEqual(vm.getAlertTitle(), AddressAlertTitle.free)
        
        vm.deliveryPossible = .paid
        
        XCTAssertEqual(vm.getAlertTitle(), AddressAlertTitle.paid)
        
        vm.deliveryPossible = .notPossible
        
        XCTAssertEqual(vm.getAlertTitle(), AddressAlertTitle.notPossible)
    }
    
    func testGetButtonText() {
        let checker = DeliveryCheckerMock()
        var deliveryPossible: DeliveryOption = .free
        let binding = Binding(get: {deliveryPossible}, set: {deliveryPossible = $0})
        let vm = AddressTextfieldViewModel(
            address: .constant(Order.mockOrder().address),
            deliveryPossible: binding,
            deliveryChecker: checker
        )
        
        vm.buttonState = .unchecked
        
        XCTAssertEqual(vm.getButtonText(), AddressButtonText.unchecked)
        
        vm.buttonState = .possible
        
        XCTAssertEqual(vm.getButtonText(), AddressButtonText.possible)
        
        vm.buttonState = .notPossible
        
        XCTAssertEqual(vm.getButtonText(), AddressButtonText.notPossible)
    }
    
    func testOnAppear() {
        let checker = DeliveryCheckerMock()
        var deliveryPossible: DeliveryOption = .free
        let binding = Binding(get: {deliveryPossible}, set: {deliveryPossible = $0})
        let vm = AddressTextfieldViewModel(
            address: .constant(Order.mockOrder().address),
            deliveryPossible: binding,
            deliveryChecker: checker
        )
        
        vm.deliveryPossible = .free
        vm.onAppear()
        
        XCTAssertEqual(vm.buttonState, .possible)
        
        vm.deliveryPossible = .paid
        vm.onAppear()
        
        XCTAssertEqual(vm.buttonState, .possible)
        
        vm.deliveryPossible = .notPossible
        vm.onAppear()
        
        XCTAssertEqual(vm.buttonState, .unchecked)
    }
    
    func testOnChangeAddressAutoCallFromAddressDidSet() async {
        let checker = DeliveryCheckerMock()
        
        var address = Order.mockOrder().address
        let bindingAddress = Binding(get: {address}, set: {address = $0})
        
        var deliveryPossible: DeliveryOption = .free
        let bindingDelivery = Binding(get: {deliveryPossible}, set: {deliveryPossible = $0})
        
        let vm = AddressTextfieldViewModel(
            address: bindingAddress,
            deliveryPossible: bindingDelivery,
            deliveryChecker: checker
        )
        
        vm.buttonState = .possible
        vm.deliveryPossible = .free
        
        vm.address.city = ""
        
        XCTAssertEqual(vm.buttonState, .unchecked)
        XCTAssertEqual(vm.deliveryPossible, .notPossible)
    }
    
}
