import SwiftUI

struct LandingView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding(.vertical)
                
                NavigationLink {
                    MenuView()
                } label: {
                    LandingViewButtonSubview(
                        color: .neapolitanGreen,
                        title: "View Menu"
                    )
                }
                ZStack {
                    NavigationLink {
                        ReserveView()
                    } label: {
                        LandingViewButtonSubview(
                            color: .neapolitanGray,
                            title: "Reserve a table"
                        )
                    }
                    
                    NavigationLink {
                        ReservationListView()
                    } label: {
                        LandingViewListButtonSubview(
                            color: .neapolitanGray,
                            icon: "list.bullet.clipboard"
                        )
                    }.offset(x: 110)
                    
                }
                ZStack {
                    NavigationLink {
                        OrderMenuView()
                    } label: {
                        LandingViewButtonSubview(
                            color: .neapolitanRed,
                            title: "Order online"
                        )
                    }
                    
                    NavigationLink {
                        OrderListView()
                    } label: {
                        LandingViewListButtonSubview(
                            color: .neapolitanRed,
                            icon: "list.bullet.clipboard"
                        )
                    }.offset(x: 110)
                }
            }
        }
    }
}

#Preview {
    LandingView()
}

struct LandingViewButtonSubview: View {
    let color: Color
    let title: String
    
    var body: some View {
        Text(title)
            .padding()
            .frame(maxWidth: 150)
            .background(color)
            .clipShape(Capsule())
            .foregroundStyle(.white)
    }
}

struct LandingViewListButtonSubview: View {
    let color: Color
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .padding()
            .frame(maxWidth: 50)
            .background(color)
            .clipShape(Circle())
            .foregroundStyle(.white)
    }
}
