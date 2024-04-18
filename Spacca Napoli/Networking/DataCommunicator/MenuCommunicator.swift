import Foundation

protocol MenuCommunicatorType {
    func loadMenu() async throws -> Menu
}

final class MenuCommunicator: MenuCommunicatorType {
    private let handler: FirebaseHandlerType
    
    init(
        handler: FirebaseHandlerType = FirebaseHandler.shared
    ) {
        self.handler = handler
    }
    
    func loadMenu() async throws -> Menu {
        try await handler.loadMenu()
    }
}
