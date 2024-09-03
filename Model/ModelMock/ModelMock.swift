import Foundation

//final class ModelMock {
//    
//}

extension GeocodeResponse {
    public static func mockGeocodeData() -> Data {
//        let bundle = Bundle(for: ModelMock.self)
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: "GeocodeTestData", ofType: "json") else {
            fatalError("GeocodeTestData.json not found.")
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("GeocodeTestData.json has bad data.")
        }
        return data
    }
    
    public static func mockGeocodeResponse() -> GeocodeResponse {
        guard let decoded = try? JSONDecoder().decode([GeocodeResponse].self, from: self.mockGeocodeData()) else {
            fatalError("GeocodeTestData.json couldn't be decoded.")
        }
        return decoded[0]
    }
}

extension Menu {
    public static func mockMenuData() -> Data {
//        let bundle = Bundle(for: ModelMock.self)
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: "MenuTestData", ofType: "json") else {
            fatalError("MenuTestData.json not found.")
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("MenuTestData.json has bad data.")
        }
        return data
    }
    
    public static func mockMenuResponse() -> Menu {
        guard let decoded = try? JSONDecoder().decode(Menu.self, from: self.mockMenuData()) else {
            fatalError("MenuTestData.json couldn't be decoded.")
        }
        return decoded
    }
    
    public static func mockMenuItem() -> MenuItem {
        guard let item = Menu.mockMenuResponse().items.first else {
            fatalError("MenuTestData.json doesn't have any items.")
        }
        return item
    }
}

extension Order {
    public static func mockOrderData() -> Data {
//        let bundle = Bundle(for: ModelMock.self)
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: "OrderTestData", ofType: "json") else {
            fatalError("OrderTestData.json not found.")
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("OrderTestData.json has bad data.")
        }
        return data
    }
    
    public static func mockOrderResponse() -> [Order] {
        guard let decoded = try? JSONDecoder().decode([Order].self, from: self.mockOrderData()) else {
            fatalError("OrderTestData.json couldn't be decoded.")
        }
        return decoded
    }
    
    public static func mockOrder() -> Order {
        guard let order = mockOrderResponse().first else {
            fatalError("OrderTestData.json doesn't have any orders.")
        }
        return order
    }
}

extension Reservation {
    public static func mockReservationData() -> Data {
//        let bundle = Bundle(for: ModelMock.self)
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: "ReservationTestData", ofType: "json") else {
            fatalError("ReservationTestData.json not found.")
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("ReservationTestData.json has bad data.")
        }
        return data
    }
    
    public static func mockReservationResponse() -> [Reservation] {
        guard let decoded = try? JSONDecoder().decode([Reservation].self, from: self.mockReservationData()) else {
            fatalError("ReservationTestData.json couldn't be decoded.")
        }
        return decoded
    }
}
