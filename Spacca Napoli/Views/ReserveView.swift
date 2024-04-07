//
//  ReserveView.swift
//  Spacca Napoli
//
//  Created by Marcin Głodzik on 06/04/2024.
//

import SwiftUI

enum RestaurantLocations: String, CaseIterable {
    case swietokrzyska = "Świętokrzyska 30"
    case ludna = "Ludna 1A"
}

struct ReserveView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    @State private var restaurant: RestaurantLocations = .swietokrzyska
    @State private var numberOfPeople = 0
    
    @State private var day: Date = .tomorrow
    @State private var hour: Date = .tomorrow
    
    @State private var isAlertShowing = false
    
    var body: some View {
        Form {
            Section {
                TextField("Your name", text: $name)
                TextField("Your email address", text: $email)
                TextField("Your phone number", text: $phone)
                Picker("Restaurant", selection: $restaurant) {
                    ForEach(RestaurantLocations.allCases, id: \.self) { restaurant in
                        Text(restaurant.rawValue)
                    }
                }
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(1..<10) { number in
                        Text("\(number)")
                    }
                }
                HStack {
                    DatePicker("Pick a date", selection: $day, in: .tomorrow..., displayedComponents: .date)
                    DatePicker("Hour", selection: $hour, in: hourRange(), displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                }
                Button(action: {
                    reserveTable()
                    isAlertShowing = true
                }, label: {
                    Text("Reserve your table")
                })
            }
        }
        
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 30
        }
        .alert("Your request is sent", isPresented: $isAlertShowing) {
            Button(action: {
                dismiss()
            }, label: {
                Text("Ok")
            })
        } message: {
            Text("Your reservation for \(createDate()) for \(numberOfPeople + 1) has been requested. Please wait for a confirmation.")
        }

    }
    
    private func hourRange() -> ClosedRange<Date> {
        let min = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: .tomorrow)!
        let max = Calendar.current.date(bySettingHour: 21, minute: 30, second: 0, of: .tomorrow)!
        return min...max
    }
    
    private func createDate() -> Date {
        var dayComponents = Calendar.current.dateComponents([.day, .month, .year], from: day)
        let hourComponents = Calendar.current.dateComponents([.hour, .minute], from: hour)
        dayComponents.hour = hourComponents.hour
        dayComponents.minute = hourComponents.minute
        let date = Calendar.current.date(from: dayComponents)!
        return date
    }
    
    private func reserveTable() {
        //add 1 to number of people
        //Send a reservation to firebase
    }
}

#Preview {
    ReserveView()
}
