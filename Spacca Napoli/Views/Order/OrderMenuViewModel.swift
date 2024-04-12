import Foundation
import SwiftUI

final class OrderMenuViewModel: ObservableObject {
    let decoder = JSONDecoder()
    
    @Published var menu = Menu()
    
    @Published var basketItems: [MenuItem] = []
    
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
    }
    
    private func getMenu() {
        let bundle = Bundle(for: MenuViewModel.self)
        guard let path = bundle.path(forResource: "Menu", ofType: "json") else { fatalError("Menu.json not found.") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Menu.json has bad data.") }
        guard let decoded = try? decoder.decode(Menu.self, from: data) else { fatalError("Menu.json cant be decoded") }
        menu = decoded
    }
    
    func tappedOn(_ item: MenuItem) {
        basketItems.append(item)
    }
    
    func buttonText() -> String {
        var price = 0
        for item in basketItems {
            price += item.price
        }
        return "Basket: \(price) PLN"
    }
}
