import SwiftUI

struct NewMenuItemView: View {
    @Environment(\.colorScheme) var colorScheme
    let menuItem: NewMenuItem
    
    var body: some View {
        HStack {
            Image(menuItem.name)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 80)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack(alignment: .leading) {
                Text(menuItem.name)
                    .font(.title2)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text(menuItem.description)
                    .font(.caption2)
                    .lineLimit(2)
            }
            Spacer()
            Text("\(menuItem.price),-")
                .font(.title2)
        }
        .foregroundStyle(colorScheme == .dark ? .white : .black)
    }
}

#Preview {
    MenuItemView(menuItem: MenuItem(name: "SPAGHETTI AL PESTO STRACCIATELLA E POMODORI CONFIT", price: 29, description: "tomato sauce, mozzarella fiordilatte, grana padano cheese D.O.P., basil"))
}
