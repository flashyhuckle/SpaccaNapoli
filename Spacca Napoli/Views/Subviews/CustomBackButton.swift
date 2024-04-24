import SwiftUI

struct CustomBackButtonView: View {
    @Environment(\.dismiss) var dismiss
    let color: Color
    let text: String
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                if text.isEmpty {
                    Image(systemName: "line.3.horizontal")
                } else {
                    Text(text)
                }
            }.tint(color)
        }
    }
}

struct CustomBackButtonModifier: ViewModifier {
    let color: Color
    let text: String
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomBackButtonView(color: color, text: text)
                }
            }
            .navigationBarBackButtonHidden()
    }
}

extension View {
    func customBackButton(color: Color) -> some View {
        modifier(CustomBackButtonModifier(color: color, text: ""))
    }
    
    func customBackButtonWithText(_ text: String, color: Color) -> some View {
        modifier(CustomBackButtonModifier(color: color, text: text))
    }
}

