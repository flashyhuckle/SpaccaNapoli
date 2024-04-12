import Foundation

final class MenuDetailViewModel: ObservableObject {
    let menuItem: MenuItem
    
    init(
        menuItem: MenuItem
    ) {
        self.menuItem = menuItem
    }
}
