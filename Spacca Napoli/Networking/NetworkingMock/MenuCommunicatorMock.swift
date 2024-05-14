import Foundation

final class MenuCommunicatorMock: MenuCommunicatorType {
    func loadMenu() async throws -> Menu {
        Menu.mockMenuResponse()
    }
}
