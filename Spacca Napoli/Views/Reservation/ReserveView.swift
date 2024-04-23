import SwiftUI

struct ReserveView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: ReserveViewModel
    
    init(
        vm: ReserveViewModel = ReserveViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        
    #warning ("improve look of this view")
        
        Form {
            Section {
                TextField("Your name", text: $vm.name)
                TextField("Your email address", text: $vm.email)
                TextField("Your phone number", text: $vm.phone)
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
                Button(action: {
                    vm.reserveTable()
                }, label: {
                    Text("Reserve your table")
                })
            }
        }
        .customBackButton(color: .neapolitanGray)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 30
        }
        .oneButtonAlert(
            title: "Request sent",
            message: "Your reservation for \(vm.createDate()) for \(vm.numberOfPeople + 1) has been requested. Please wait for a confirmation.",
            isPresented: $vm.isAlertShowing
        ) {
            dismiss()
        }
    }
}

#Preview {
    ReserveView()
}
