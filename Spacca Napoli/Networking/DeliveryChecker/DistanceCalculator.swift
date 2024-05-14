import CoreLocation

class DistanceCalculator {
    static func calculateDistance(from location: GeocodeResponse) -> Double {
        let spacca = CLLocation(latitude: Constants.spaccaLatitude, longitude: Constants.spaccaLongitude)
        let customer = CLLocation(latitude: location.latDouble, longitude: location.lonDouble)
        let distance = spacca.distance(from: customer)
        return distance
    }
}
