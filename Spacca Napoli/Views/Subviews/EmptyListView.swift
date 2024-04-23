import SwiftUI

class EmptyListViewCreator {
    static func emptyReservationList() -> EmptyListView {
        EmptyListView(icon: "list.clipboard", title: "You have no reservation history", message: "Pull to refresh or try again after placing a reservation.")
    }
    
    static func emptyOrderList() -> EmptyListView {
        EmptyListView(icon: "basket", title: "You have no orders", message: "Pull to refresh or try again after ordering something.")
    }
}

struct EmptyListView: View {
    let icon: String
    let title: String
    let message: String
    
    init(icon: String, title: String, message: String) {
        self.icon = icon
        self.title = title
        self.message = message
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 120)
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                    .padding()
                Text(title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text(message)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    EmptyListViewCreator.emptyOrderList()
}
