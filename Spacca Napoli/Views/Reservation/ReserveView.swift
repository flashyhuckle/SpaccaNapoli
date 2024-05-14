import SwiftUI

struct ReserveView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: ReserveViewModel
    
    init(
        vm: ReserveViewModel = ReserveViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
        UIDatePicker.appearance().minuteInterval = 30
    }
    
    var body: some View {
        Form {
            Section(content: {
                TextField("Your name", text: $vm.name)
                    .indicated($vm.isNameValid)
                TextField("Your email address", text: $vm.email)
                    .keyboardType(.emailAddress)
                    .indicated($vm.isEmailValid)
                TextField("Your phone number", text: $vm.phone)
                    .keyboardType(.numberPad)
                    .onChange(of: vm.phone) {
                        vm.phone = vm.phone.formatPhoneNumber()
                    }
                    .indicated($vm.isPhoneValid)
            }, header: {
                SectionHeaderView(text: "Your data", color: .neapolitanGray)
            })
            
            Section(content: {
                Picker("Restaurant", selection: $vm.restaurant) {
                    ForEach(RestaurantLocation.allCases, id: \.self) { restaurant in
                        Text(restaurant.rawValue)
                    }
                }
                Picker("Number of people", selection: $vm.numberOfPeople) {
                    ForEach(1..<10) { number in
                        Text("\(number)")
                    }
                }
                HStack {
                    DatePicker("Pick a date", selection: $vm.day, in: vm.dateRange(), displayedComponents: .date)
                    DatePicker("Pick hour", selection: $vm.hour, in: vm.hourRange(), displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }, header: {
                SectionHeaderView(text: "Reservation", color: .neapolitanGray)
            })
        }
        .withBottomButton("Reserve your table", icon: "list.bullet.clipboard") {
            vm.reserveButtonPressed()
        }
        .customBackButton(color: .neapolitanGray)
        .oneButtonAlert(
            title: vm.alertTitle(),
            message: vm.alertMessage(),
            isPresented: $vm.isAlertShowing
        ) {
            if vm.allFieldsValid() {
                dismiss()
            }
        }
    }
}

#Preview {
    ReserveView(vm: ReserveViewModel(communicator: ReservationCommunicatorMock()))
}
