import XCTest

@testable import Spacca_Napoli

final class GeocodeAPITests: XCTestCase {
    private let address = Order.mockOrder().address
    
    func testGetCoordinatesGoodData() async {
        let handler = URLSessionHandlerMockGeocodeData()
        let api: GeocodeAPIType = GeocodeAPI(handler: handler)
        
        if let coordinates = try? await api.getCoordinates(for: address) {
            XCTAssertEqual(coordinates.lat, "52.235400350000006")
            XCTAssertEqual(coordinates.lon, "20.982455207962907")
        } else {
            XCTFail()
        }
    }
    
    func testGetCoordinatesEmptyData() async {
        let handler = URLSessionHandlerMockEmptyData()
        let api: GeocodeAPIType = GeocodeAPI(handler: handler)
        
        do {
            _ = try await api.getCoordinates(for: address)
        } catch {
            XCTAssertTrue(error is DecodeError)
            XCTAssertEqual(error as? DecodeError, DecodeError.cannotDecodeData)
        }
    }
    
    func testGetCoordinatesNoApiKey() async {
        let handler = URLSessionHandlerMockNoKey()
        let api: GeocodeAPIType = GeocodeAPI(handler: handler)
        
        do {
            _ = try await api.getCoordinates(for: address)
        } catch {
            XCTAssertTrue(error is RequestError)
            XCTAssertEqual(error as? RequestError, RequestError.unauthorized)
        }
    }
    
    func testGetCoordinatesBadQuery() async {
        let handler = URLSessionHandlerMockBadQuery()
        let api: GeocodeAPIType = GeocodeAPI(handler: handler)
        
        do {
            _ = try await api.getCoordinates(for: address)
        } catch {
            XCTAssertTrue(error is RequestError)
            XCTAssertEqual(error as? RequestError, RequestError.cannotBuildURL)
        }
    }
    
    func testGetCoordinatesBadResponse() async {
        let handler = URLSessionHandlerMockBadResponse()
        let api: GeocodeAPIType = GeocodeAPI(handler: handler)
        
        do {
            _ = try await api.getCoordinates(for: address)
        } catch {
            XCTAssertTrue(error is RequestError)
            XCTAssertEqual(error as? RequestError, RequestError.badResponse)
        }
    }
    
    func testGetCoordinatesBadStatusCode() async {
        let handler = URLSessionHandlerMockBadStatusCode()
        let api: GeocodeAPIType = GeocodeAPI(handler: handler)
        
        handler.statusCode = 400
        
        do {
            _ = try await api.getCoordinates(for: address)
        } catch {
            XCTAssertTrue(error is RequestError)
            XCTAssertEqual(error as? RequestError, RequestError.clientError(statusCode: 400))
        }
        
        handler.statusCode = 500
        
        do {
            _ = try await api.getCoordinates(for: address)
        } catch {
            XCTAssertTrue(error is RequestError)
            XCTAssertEqual(error as? RequestError, RequestError.serverError(statusCode: 500))
        }
    }
}
