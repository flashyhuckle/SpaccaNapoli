import SwiftUI

struct AddressTextfieldView: View {
    enum Field: Hashable {
        case street, building, apartment, city, postal
    }
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Field?
    
    @StateObject var vm: AddressTextfieldViewModel
    
    var body: some View {
        List {
            TextField("Street", text: $vm.address.street)
                .focused($focusedField, equals: .street)
                .submitLabel(.next)
                .autocorrectionDisabled()
            
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
        .withBottomButton(
            vm.getButtonText(),
            color: vm.getButtonColor()
        ) {
            vm.checkAddress()
        }
        .customBackButton(color: .neapolitanRed)
        .onAppear {
            vm.onAppear()
        }
        .oneButtonAlert(
            title: "Delivery is possible",
            message: "You can finish your order now",
            isPresented: $vm.isAlertShowing
        ) {
            dismiss()
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
