import Foundation

final class MenuViewModel: ObservableObject {
    let decoder = JSONDecoder()
    @Published var menu = Menu()
    
    func getMenu() {
        let bundle = Bundle(for: MenuViewModel.self)
        guard let path = bundle.path(forResource: "Menu", ofType: "json") else { fatalError("Menu.json not found.") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Menu.json has bad data.") }
        guard let decoded = try? decoder.decode(Menu.self, from: data) else { fatalError("Menu.json cant be decoded") }
        menu = decoded
    }
}
