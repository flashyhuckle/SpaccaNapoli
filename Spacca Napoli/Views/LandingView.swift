import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
                
                NavigationLink {
                    MenuView()
                } label: {
                    Text("View Menu")
                        .padding()
                        .frame(maxWidth: 150)
                        .background(.green)
                        .clipShape(Capsule())
                        .foregroundStyle(.white)
                }
                
                NavigationLink {
                    ReserveView()
                } label: {
                    Text("Reserve a table")
                        .padding()
                        .frame(maxWidth: 150)
                        .background(.gray)
                        .clipShape(Capsule())
                        .foregroundStyle(.white)
                }
                
                NavigationLink {
                    OrderMenuView()
                } label: {
                    Text("Order online")
                        .padding()
                        .frame(maxWidth: 150)
                        .background(.red)
                        .clipShape(Capsule())
                        .foregroundStyle(.white)
                }
                
            }
        }
    }
}

#Preview {
    LandingView()
}
