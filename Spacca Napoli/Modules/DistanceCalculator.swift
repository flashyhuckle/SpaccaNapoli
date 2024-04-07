import CoreLocation

class DistanceCalculator {
    static func calculateDistance(from location: GeocodeResponse) -> Double {
        let spacca = CLLocation(latitude: 52.234924305828386, longitude: 21.0055726745955)
        let customer = CLLocation(latitude: location.latFloat, longitude: location.lonFloat)
        let distance = spacca.distance(from: customer)
        return distance
    }
}
