import Foundation
import SwiftUI

final class MenuViewModel: ObservableObject {
    private let communicator: MenuCommunicatorType
    @Published var menu = Menu()
    
    init(
        communicator: MenuCommunicatorType = MenuCommunicator()
    ) {
        self.communicator = communicator
    }
    
    private let colors: [String: Color] = [
        "Cold Apetizers and Salads" : .green,
        "Hot Apetizers" : .red,
        "Pizza Rosa" : .red,
        "Pizza Bianca" : .gray,
        "Pizza Special" : .yellow,
        "Calzoni" : .brown,
        "Pasta Fresca" : .green,
        "Desserts" : .pink
    ]
    
    func onAppear() {
        getMenu()
    }
    
    private func getMenu() {
        Task { @MainActor in
            self.menu = try await communicator.loadMenu()
        }
    }
    
    func colorFor(_ category: String) -> Color {
        if let color = colors[category] {
            return color
        } else {
            return .blue
        }
    }
    
    func menuFilteredBy(_ category: String) -> [MenuItem] {
        menu.items.filter { $0.category == category }
    }
}
