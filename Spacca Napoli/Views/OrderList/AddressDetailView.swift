import CoreLocation
import MapKit
import SwiftUI

extension Marker: Identifiable {
    public var id: UUID {
        UUID()
    }
}

extension MapPolyline: Identifiable {
    public var id: UUID {
        UUID()
    }
}

struct AddressDetailView: View {
    @StateObject var vm: AddressDetailViewModel
    
    var body: some View {
        ZStack {
            Map(position: $vm.position) {
                ForEach(vm.markerArray) { item in
                    item
                        .tint(.neapolitanRed)
                }
                
                ForEach(vm.routeArray) { route in
                    route
                        .stroke(.neapolitanRed, lineWidth: 2)
                }
            }.allowsHitTesting(false)
            
            VStack {
                Spacer()
                AddressView(address: vm.address)
                    .padding()
                    .background(.neapolitanGray.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            
        }
        .navigationTitle("Delivery")
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton(color: .neapolitanRed)
        
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    AddressDetailView(
        vm: AddressDetailViewModel(
            address: Address(
                street: "Chłodna",
                building: "51",
                apartment: "100",
                city: "Warszawa",
                postalCode: "00-867"
            )
        )
    )
}
