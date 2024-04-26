import SwiftUI

struct AddressView: View {
    let address: Address
    
    init(
        address: Address
    ) {
        self.address = address
    }
    
    var body: some View {
        HStack {
            Image(systemName: "bicycle")
                .font(.title)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(address.street)
                    Text(buildingNumberText())
                }
                HStack {
                    Text(address.postalCode)
                    Text(address.city)
                }
            }
        }
    }
    
    private func buildingNumberText() -> String {
        if address.apartment.isEmpty {
            address.building
        } else {
            address.building + "/" + address.apartment
        }
    }
}

#Preview {
    AddressView(
        address: Address(
            street: "Chłodna",
            building: "51",
            apartment: "100",
            city: "Warszawa",
            postalCode: "00-867"
        )
    )
}
