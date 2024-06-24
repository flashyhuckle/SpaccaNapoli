import MapKit
import SwiftUI

class AddressDetailViewModel: ObservableObject {
    let order: Order
    private let api: GeocodeAPIType
    private let communicator: DeliveryCommunicatorType
    
    @Published var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: Constants.spaccaLatitude, longitude: Constants.spaccaLongitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    private var user: CLLocationCoordinate2D?
    private var driver: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Constants.spaccaLatitude, longitude: Constants.spaccaLongitude)
    private var route: MKRoute?
    
    @Published var markerArray = [Marker("Spacca", systemImage: "fork.knife", coordinate: CLLocationCoordinate2D(latitude: Constants.spaccaLatitude, longitude: Constants.spaccaLongitude))]
    
    @Published var routeArray = [MapPolyline]()
    
    init(
        order: Order,
        api: GeocodeAPIType = GeocodeAPI(),
        communicator: DeliveryCommunicatorType = DeliveryCommunicator()
    ) {
        self.order = order
        self.api = api
        self.communicator = communicator
    }
    
    func updateUI() {
        withAnimation {
            if let user {
                if markerArray.count > 1 {
                    markerArray.removeLast()
                }
                markerArray.append(Marker("You", systemImage: "person", coordinate: user))
                let lat = (driver.latitude + user.latitude) / 2
                let lon = (driver.longitude + user.longitude) / 2
                let latDel = abs(driver.latitude - user.latitude) * 1.3
                let lonDel = abs(driver.longitude - user.longitude) * 1.3
                
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                        span: MKCoordinateSpan(latitudeDelta: latDel, longitudeDelta: lonDel)
                    )
                )
            }
            if let route {
                routeArray.removeAll()
                routeArray.append(MapPolyline(route))
            }
        }
    }
    
    func onAppear() async {
        observeDriverCoordinates()
        await getUserCoordinates()
    }
    
    private func getUserCoordinates() async {
        do {
            if let coordinates = try await api.getCoordinates(for: order.address) {
                user = coordinates.CLLC2D
                try await getRoute(to: coordinates.CLLC2D)
            }
        } catch {
            print(error)
        }
    }
    
    private func observeDriverCoordinates() {
        communicator.observe(order) { delivery in
            self.markerArray[0] = (Marker("Driver", systemImage: "bicycle.circle", coordinate: delivery.CLLC2D))
            self.driver = delivery.CLLC2D
            
            Task {
                if let user = self.user {
                    try await self.getRoute(to: user)
                }
            }
        }
    }
    
    private func getRoute(to destination: CLLocationCoordinate2D) async throws {
        
        DispatchQueue.main.async {
            self.route = nil
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: driver))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        let directions = MKDirections(request: request)
        let response = try await directions.calculate()
        
        DispatchQueue.main.async {
            self.route = response.routes.first
            self.updateUI()
        }
    }
}
