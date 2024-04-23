import SwiftUI

struct CustomBackButtonView: View {
    @Environment(\.dismiss) var dismiss
    let color: Color
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                Image(systemName: "line.3.horizontal")
            }.tint(color)
        }
    }
}

struct CustomBackButtonModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomBackButtonView(color: color)
                }
            }
            .navigationBarBackButtonHidden()
    }
}

extension View {
    func customBackButton(color: Color) -> some View {
        modifier(CustomBackButtonModifier(color: color))
    }
}
