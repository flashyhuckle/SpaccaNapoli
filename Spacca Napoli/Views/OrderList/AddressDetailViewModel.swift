import MapKit
import SwiftUI

class AddressDetailViewModel: ObservableObject {
    let address: Address
    let spacca = CLLocationCoordinate2D(latitude: 52.234924305828386, longitude: 21.0055726745955)
    
    private let api: GeocodeAPIType
    
    @Published var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 52.234924305828386, longitude: 21.0055726745955),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    @Published var user: CLLocationCoordinate2D?
    @Published var route: MKRoute?
    
    @Published var markerArray = [Marker("Spacca", systemImage: "fork.knife", coordinate: CLLocationCoordinate2D(latitude: 52.234924305828386, longitude: 21.0055726745955))]
    
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
                let lat = (spacca.latitude + user.latitude) / 2
                let lon = (spacca.longitude + user.longitude) / 2
                let latDel = abs(spacca.latitude - user.latitude) * 1.3
                let lonDel = abs(spacca.longitude - user.longitude) * 1.3
                
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
    
    func onAppear() {
        Task { @MainActor in
            await getCoordinates()
        }
    }
    
    private func getCoordinates() async {
        let api: GeocodeAPIType = GeocodeAPI()
        do {
            let coordinates = try await api.getCoordinates(for: address)
            try await getRoute(to: CLLocationCoordinate2D(latitude: coordinates!.latDouble, longitude: coordinates!.lonDouble))
        } catch {
            print(error)
        }
    }
    
    private func getRoute(to destination: CLLocationCoordinate2D) async throws {
        
        DispatchQueue.main.async {
            self.route = nil
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: spacca))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        let directions = MKDirections(request: request)
        let response = try await directions.calculate()
        
        DispatchQueue.main.async {
            self.route = response.routes.first
            self.user = destination
            self.updateUI()
        }
    }
}
