import SwiftUI

struct MenuDetailView: View {
    let vm: MenuDetailViewModel
    
    var body: some View {
        
    #warning ("improve look of this view")
        
        VStack {
            Text(vm.menuItem.name)
                .font(.title)
                .padding(.horizontal)
            Image(vm.menuItem.name)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            Text(vm.menuItem.description)
                .padding()
            Text("\(vm.menuItem.price),-")
                .font(.title)
        }
    }
}

#Preview {
    MenuDetailView(
        vm: MenuDetailViewModel(
            menuItem: MenuItem(
                name: "SPAGHETTI AL PESTO STRACCIATELLA E POMODORI CONFIT",
                price: 29,
                description: "tomato sauce, mozzarella fiordilatte, grana padano cheese D.O.P., basil",
                category: "Pizza Bianca"
            )
        )
    )
}
