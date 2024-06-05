import XCTest

@testable import Spacca_Napoli

final class ReserveViewModelTests: XCTestCase {
    
    
    func testReserveButtonPressedFieldsInvalid() async throws {
        let communicator = ReservationCommunicatorMock()
        let vm = ReserveViewModel(communicator: communicator)
        
        vm.isEmailValid = false
        vm.isNameValid = false
        vm.isPhoneValid = false
        
        try await vm.reserveButtonPressed()
        
        XCTAssertTrue(vm.isAlertShowing)
        XCTAssertFalse(communicator.reservationPlaced)
    }
    
    func testReserveButtonPressedFieldsValid() async throws {
        let communicator = ReservationCommunicatorMock()
        let vm = ReserveViewModel(communicator: communicator)
        
        vm.isEmailValid = true
        vm.isNameValid = true
        vm.isPhoneValid = true
        
        try await vm.reserveButtonPressed()
        
        XCTAssertTrue(vm.isAlertShowing)
        XCTAssertTrue(communicator.reservationPlaced)
    }
    
    func testReserveTable() async throws {
        let communicator = ReservationCommunicatorMock()
        let vm = ReserveViewModel(communicator: communicator)
        try await vm.reserveTable()
        
        XCTAssertTrue(vm.isAlertShowing)
        XCTAssertTrue(communicator.reservationPlaced)
    }
    
    func testAllfieldsValid() {
        let communicator = ReservationCommunicatorMock()
        let vm = ReserveViewModel(communicator: communicator)
        
        vm.isEmailValid = false
        vm.isNameValid = false
        vm.isPhoneValid = false
        
        XCTAssertFalse(vm.allFieldsValid())
        
        vm.isEmailValid = true
        
        XCTAssertFalse(vm.allFieldsValid())
        
        vm.isNameValid = true
        
        XCTAssertFalse(vm.allFieldsValid())
        
        vm.isPhoneValid = true
        
        XCTAssertTrue(vm.allFieldsValid())
    }
    
    func testAlertTitle() {
        let communicator = ReservationCommunicatorMock()
        let vm = ReserveViewModel(communicator: communicator)
        
        vm.isEmailValid = false
        vm.isNameValid = false
        vm.isPhoneValid = false
        
        XCTAssertEqual(vm.alertTitle(), ReservationAlertTitle.cannotProcess)
        
        vm.isEmailValid = true
        
        XCTAssertEqual(vm.alertTitle(), ReservationAlertTitle.cannotProcess)
        
        vm.isNameValid = true
        
        XCTAssertEqual(vm.alertTitle(), ReservationAlertTitle.cannotProcess)
        
        vm.isPhoneValid = true
        
        XCTAssertEqual(vm.alertTitle(), ReservationAlertTitle.requestSent)
    }
    
    func testAlertMessage() {
        let communicator = ReservationCommunicatorMock()
        let vm = ReserveViewModel(communicator: communicator)
        
        vm.isEmailValid = false
        vm.isNameValid = false
        vm.isPhoneValid = false
        
        XCTAssertEqual(vm.alertMessage(), ReservationAlertMessage.badData)
        
        vm.isEmailValid = true
        
        XCTAssertEqual(vm.alertMessage(), ReservationAlertMessage.badData)
        
        vm.isNameValid = true
        
        XCTAssertEqual(vm.alertMessage(), ReservationAlertMessage.badData)
        
        vm.isPhoneValid = true
        
        XCTAssertEqual(vm.alertMessage(), ReservationAlertMessage.requestSent(date: vm.createDate(), people: vm.numberOfPeople + 1))
    }
}
