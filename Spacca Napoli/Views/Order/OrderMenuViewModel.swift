import Foundation
import SwiftUI

final class OrderMenuViewModel: ObservableObject {
    private let communicator: MenuCommunicatorType
    
    @Published var menu = Menu()
    @Published var basket = Basket()
    @Published var basketButtonDisabled = true
    @Published var animation = false
    @Published var toBasketViews = [ItemToBasketView]()
    
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
    
    func onLoad() {
        getMenu()
    }
    
    func onAppear() {
        checkBasket()
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
    
    func tappedOn(_ item: MenuItem, in location: CGPoint) {
        spawnView(item: item, location: location)
        basket.items.append(item)
        checkBasket()
        animateButton()
    }
    
    private func spawnView(item: MenuItem, location: CGPoint) {
        let view = ItemToBasketView(imageName: item.name, offset: location)
        toBasketViews.append(view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation {
                _ = self.toBasketViews.removeFirst()
            }
        }
    }
    
    private func animateButton() {
        withAnimation {
            animation = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation {
                self.animation = false
            }
        }
    }
    
    private func checkBasket() {
        basketButtonDisabled = basket.items.isEmpty
    }
    
    func buttonText() -> String {
        var price = 0
        for item in basket.items {
            price += item.price
        }
        return "Basket: \(price) PLN"
    }
}
