import SwiftUI

struct OrderPriceListSubview: View {
    let title: String
    let price: Int
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
            Spacer()
            Text("\(price),-")
                .font(.title2)
        }
    }
}

#Preview {
    OrderPriceListSubview(title: "Total", price: 150)
}
