import Foundation

extension Date {
    static var tomorrow: Date {
        var components = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        components.day! += 1
        components.hour = 12
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
}
