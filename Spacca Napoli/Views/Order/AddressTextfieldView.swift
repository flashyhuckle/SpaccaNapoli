import SwiftUI

struct AddressTextfieldView: View {
    enum Field: Hashable {
        case street, building, apartment, city, postal
    }
    
    @FocusState private var focusedField: Field?
    
    @StateObject var vm: AddressTextfieldViewModel
    
    var body: some View {
        ZStack {
            List {
                Group {
                    TextField("Street", text: $vm.address.street)
                        .focused($focusedField, equals: .street)
                        .submitLabel(.next)
                    
                    TextField("Building", text: $vm.address.building)
                        .focused($focusedField, equals: .building)
                        .submitLabel(.next)
                    
                    TextField("Apartment number", text: $vm.address.apartment)
                        .focused($focusedField, equals: .apartment)
                        .submitLabel(.next)
                    
                    TextField("City", text: $vm.address.city)
                        .focused($focusedField, equals: .city)
                        .submitLabel(.next)
                    
                    TextField("Postal Code", text: $vm.address.postalCode)
                        .focused($focusedField, equals: .postal)
                        .submitLabel(.go)
                }
            }
            .onSubmit {
                switch focusedField {
                case .street:
                    focusedField = .building
                case .building:
                    focusedField = .apartment
                case .apartment:
                    focusedField = .city
                case .city:
                    focusedField = .postal
                case .postal:
                    focusedField = nil
                    vm.checkAddress()
                case nil:
                    focusedField = nil
                }
            }
            VStack {
                Spacer()
                Button(action: {
                    vm.checkAddress()
                }, label: {
                    Text(vm.getButtonText())
                        .foregroundStyle(.white)
                        .padding()
                        .background(vm.getButtonColor())
                        .clipShape(Capsule())
                })
            }
        }
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    AddressTextfieldView(
        vm: AddressTextfieldViewModel(
            address: .constant(
                Address(
                    street: "Chłodna",
                    building: "51",
                    apartment: "100",
                    city: "Warszawa",
                    postalCode: "00-867"
                )
            ),
            deliveryPossible: .constant(DeliveryOption.notPossible)
        )
    )
}
