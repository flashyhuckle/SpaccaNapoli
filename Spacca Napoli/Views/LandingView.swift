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
                ZStack {
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
                        ReserveView()
                    } label: {
                        Image(systemName: "list.bullet.clipboard")
                            .padding()
                            .frame(maxWidth: 50)
                            .background(.gray)
                            .clipShape(Circle())
                            .foregroundStyle(.white)
                    }.offset(x: 110)
                    
                }
                
                ZStack {
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
                    
                    NavigationLink {
                        OrderListView()
                    } label: {
                        Image(systemName: "list.bullet.clipboard")
                            .padding()
                            .frame(maxWidth: 50)
                            .background(.red)
                            .clipShape(Circle())
                            .foregroundStyle(.white)
                    }.offset(x: 110)
                }
            }
        }
    }
}

#Preview {
    LandingView()
}
