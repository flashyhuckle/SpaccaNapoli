import SwiftUI

struct OrderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var basketItems: [MenuItem]
    
    @State private var street = "Chłodna"
    @State private var building = "51"
    @State private var apartment = "100"
    @State private var city = "Warszawa"
    @State private var postalCode = "00-867"
    
    @State private var isDeliveryPossible = false
    @State private var isLabelVisible = false
    @State private var isAlertVisible = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    TextField("Street", text: $street)
                    TextField("Building", text: $building)
                    TextField("Apartment number", text: $apartment)
                    TextField("City", text: $city)
                    TextField("Postal Code", text: $postalCode)
                }
                .padding()
                Button("Check address") {
                    buttonPressed()
                }
                if isLabelVisible {
                    HStack {
                        Image(systemName: isDeliveryPossible ? "checkmark.circle" : "exclamationmark.triangle")
                        Text(isDeliveryPossible ? "Delivery is possible!" : "Sorry, you are too far.")
                    }
                    .padding()
                    .background(isDeliveryPossible ? .green : .red)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
            VStack {
                Spacer()
                Button(action: {
                    isAlertVisible = true
                }, label: {
                    Text("Place an order")
                .foregroundStyle(.white)
                .padding()
                .background(Color(red: 0.8, green: 0, blue: 0))
                .clipShape(Capsule())
                })
            }
        }
        .alert("Your order has been placed!", isPresented: $isAlertVisible) {
            
            Button(action: {
                basketItems.removeAll()
                dismiss()
            }, label: {
                Text("Ok")
            })
        }
    }
    
    private func countPrice() -> Int {
        var price = 10
        for item in basketItems {
            price += item.price
        }
        return price
    }
    private func buttonPressed() {
        Task {
            let coordinates = try await ApiCaller().getCoordinates(for: Address(street: street, building: building, city: city, postalCode: postalCode))
            let distance = DistanceCalculator.calculateDistance(from: coordinates).rounded()
            print(distance)
            if distance < 5000 {
                isDeliveryPossible = true
            } else {
                isDeliveryPossible = false
            }
            isLabelVisible = true
        }
    }
}

//#Preview {
//    OrderView()
//}
