import SwiftUI

struct SectionHeaderView: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.title)
            .foregroundStyle(color)
    }
}

#Preview {
    SectionHeaderView(text: "Upcoming", color: .neapolitanGreen)
}
