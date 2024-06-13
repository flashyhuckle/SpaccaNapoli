import XCTest

@testable import Spacca_Napoli

final class ReservationListViewModelTests: XCTestCase {
    
    func testGetReservations() {
        #warning("testing get reservations?")
    }
    
    func testOnAppear() async {
        let communicator = ReservationCommunicatorMock()
        let vm = ReservationListViewModel(communicator: communicator)
        
        XCTAssertTrue(vm.reservations.isEmpty)
        
        await vm.onAppear()
        
        XCTAssertFalse(vm.reservations.isEmpty)
    }
    
    func testRefresh() async {
        let communicator = ReservationCommunicatorMock()
        let vm = ReservationListViewModel(communicator: communicator)
        
        XCTAssertTrue(vm.reservations.isEmpty)
        
        await vm.refresh()
        
        XCTAssertFalse(vm.reservations.isEmpty)
    }
    
    func testUpcomingReservations() async {
        let communicator = ReservationCommunicatorMock()
        let vm = ReservationListViewModel(communicator: communicator)
        
        await vm.refresh()
        
        let upcomingReservations = vm.upcomingReservations()
        
        for upcomingReservation in upcomingReservations {
            XCTAssertTrue(upcomingReservation.date > Date.now)
        }
        
    }
    
    func testPastReservations() async {
        let communicator = ReservationCommunicatorMock()
        let vm = ReservationListViewModel(communicator: communicator)
        
        await vm.refresh()
        
        let pastReservations = vm.pastReservations()
        
        for pastReservation in pastReservations {
            XCTAssertTrue(pastReservation.date < Date.now)
        }
    }
}
