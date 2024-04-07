import Foundation
import SwiftUI

final class MenuViewModel: ObservableObject {
    let decoder = JSONDecoder()
    @Published var newMenu = NewMenu()
    
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
    
    func getNewMenu() {
        let bundle = Bundle(for: MenuViewModel.self)
        guard let path = bundle.path(forResource: "NewMenu", ofType: "json") else { fatalError("Menu.json not found.") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Menu.json has bad data.") }
        guard let decoded = try? decoder.decode(NewMenu.self, from: data) else { fatalError("Menu.json cant be decoded") }
        newMenu = decoded
    }
}
