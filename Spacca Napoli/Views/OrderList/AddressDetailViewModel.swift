import MapKit
import SwiftUI

class AddressDetailViewModel: ObservableObject {
    let address: Address
    let spacca = CLLocationCoordinate2D(latitude: 52.234924305828386, longitude: 21.0055726745955)
    
    private let api: GeocodeAPIType
    
    @Published var user: CLLocationCoordinate2D?
    @Published var route: MKRoute?
    @Published var animate = false
    
    init(
        address: Address,
        api: GeocodeAPIType = GeocodeAPI()
    ) {
        self.address = address
        self.api = api
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
            try await drawMap(to: CLLocationCoordinate2D(latitude: coordinates!.latDouble, longitude: coordinates!.lonDouble))
        } catch {
            print(error)
        }
    }
    
    private func drawMap(to destination: CLLocationCoordinate2D) async throws {
        
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
        }
    }
}
