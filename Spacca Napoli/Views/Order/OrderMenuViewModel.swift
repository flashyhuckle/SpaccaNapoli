import Foundation
import SwiftUI

final class OrderMenuViewModel: ObservableObject {
    private let communicator: MenuCommunicatorType
    
    @Published var menu = Menu()
    @Published var basket = Basket()
    @Published var basketButtonDisabled = true
    @Published var animation = false
    
    init(
        communicator: MenuCommunicatorType = MenuCommunicator()
    ) {
        self.communicator = communicator
    }
    
    let colours: [String: Color] = [
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
        checkBasket()
    }
    
    private func getMenu() {
        Task { @MainActor in
            self.menu = try await communicator.loadMenu()
        }
    }
    
    func menuFilteredBy(_ category: String) -> [MenuItem] {
        menu.items.filter { $0.category == category }
    }
    
    func tappedOn(_ item: MenuItem) {
        basket.items.append(item)
        checkBasket()
        animateButton()
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
