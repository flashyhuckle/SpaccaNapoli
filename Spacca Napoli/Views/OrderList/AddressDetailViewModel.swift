import MapKit
import SwiftUI

class AddressDetailViewModel: ObservableObject {
    let address: Address
    private let api: GeocodeAPIType
    
    @Published var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: Constants.spaccaLatitude, longitude: Constants.spaccaLongitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    private var user: CLLocationCoordinate2D?
    private var route: MKRoute?
    
    @Published var markerArray = [Marker("Spacca", systemImage: "fork.knife", coordinate: CLLocationCoordinate2D(latitude: Constants.spaccaLatitude, longitude: Constants.spaccaLongitude))]
    
    @Published var routeArray = [MapPolyline]()
    
    init(
        address: Address,
        api: GeocodeAPIType = GeocodeAPI()
    ) {
        self.address = address
        self.api = api
    }
    
    func updateUI() {
        withAnimation {
            if let user {
                markerArray.append(Marker("You", systemImage: "person", coordinate: user))
                let lat = (Constants.spaccaLatitude + user.latitude) / 2
                let lon = (Constants.spaccaLongitude + user.longitude) / 2
                let latDel = abs(Constants.spaccaLatitude - user.latitude) * 1.3
                let lonDel = abs(Constants.spaccaLongitude - user.longitude) * 1.3
                
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                        span: MKCoordinateSpan(latitudeDelta: latDel, longitudeDelta: lonDel)
                    )
                )
            }
            if let route {
                routeArray.append(MapPolyline(route))
            }
        }
    }
    
    func onAppear() async {
        await getCoordinates()
    }
    
    private func getCoordinates() async {
//        let api: GeocodeAPIType = GeocodeAPI()
        do {
            if let coordinates = try await api.getCoordinates(for: address) {
                user = coordinates.CLLC2D
                try await getRoute(to: coordinates.CLLC2D)
            }
        } catch {
            print(error)
        }
    }
    
    private func getRoute(to destination: CLLocationCoordinate2D) async throws {
        
        DispatchQueue.main.async {
            self.route = nil
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Constants.spaccaLatitude, longitude: Constants.spaccaLongitude)))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        let directions = MKDirections(request: request)
        let response = try await directions.calculate()
        
        DispatchQueue.main.async {
            self.route = response.routes.first
            self.updateUI()
        }
    }
}
