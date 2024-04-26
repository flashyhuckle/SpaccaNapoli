import SwiftUI

struct MenuDetailView: View {
    let vm: MenuDetailViewModel
    
    var body: some View {
        ZStack {
            Image(vm.menuItem.name)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.1)
                
            VStack {
                Text(vm.menuItem.name)
                    .font(.title)
                    .padding()
                Image(vm.menuItem.name)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(vm.menuItem.description)
                    .padding()
                Text("\(vm.menuItem.price),-")
                    .font(.title)
            }
            .frame(maxWidth: 300)
            .multilineTextAlignment(.center)
        }
        .customBackButton(color: .neapolitanGreen)
    }
}

#Preview {
    MenuDetailView(
        vm: MenuDetailViewModel(
            menuItem: MenuItem(
                name: "PROSCIUTTO E MOZZARELLA",
                price: 29,
                description: "tomato sauce, mozzarella fiordilatte, grana padano cheese D.O.P., basil",
                category: "Pizza Bianca"
            )
        )
    )
}
