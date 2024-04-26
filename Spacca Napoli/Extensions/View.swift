import SwiftUI

extension View {
    func navigationBarColor(_ color: UIColor) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: color]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: color]
    }
}

struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }

}

struct InvalidIndicated: ViewModifier {
    @Binding var isValid: Bool
    func body(content: Content) -> some View {
        HStack {
            content
            if !isValid {
                Spacer()
                Image(systemName: "exclamationmark.circle")
                    .foregroundStyle(Color.neapolitanRed)
            }
        }
    }
}

extension View {
    func indicated(_ isValid: Binding<Bool>) -> some View {
        modifier(InvalidIndicated(isValid: isValid))
    }
}

extension View {
    func withBottomButton(
        _ title: String,
        icon: String? = nil,
        color: Color = .neapolitanRed,
        visible: Bool = true,
        action: @escaping () -> Void
    ) -> some View {
        modifier(BottomButton(action: action, icon: icon, title: title, color: color, visible: visible))
    }
}

struct BottomButton: ViewModifier {
    let action: (() -> Void)
    let icon: String?
    let title: String
    let color: Color
    let visible: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                if visible {
                    Button(action: {
                        action()
                    }, label: {
                        HStack {
                            if let icon {
                                Image(systemName: icon)
                            }
                            Text(title)
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .background(color)
                        .clipShape(Capsule())
                    })
                }
            }
        }
    }
}


extension View {
     func withBottomNavLink<Destination: View>(
        _ title: String,
        icon: String? = nil,
        color: Color = .neapolitanRed,
        disabled: Bool = false,
        visible: Bool = true,
        bounce: Bool = false,
        destination: () -> Destination
     ) -> some View {
         modifier(BottomNavLink(destination: destination, icon: icon, title: title, color: color, disabled: disabled, visible: visible, bounce: bounce))
    }
}

struct BottomNavLink<Destination>: ViewModifier where Destination: View {
    let destination: Destination
    let icon: String?
    let title: String
    let color: Color
    let disabled: Bool
    let visible: Bool
    let bounce: Bool
    
    init(
        destination: () -> Destination,
        icon: String?,
        title: String,
        color: Color,
        disabled: Bool,
        visible: Bool,
        bounce: Bool
    ) {
        self.destination = destination()
        self.icon = icon
        self.title = title
        self.color = color
        self.disabled = disabled
        self.visible = visible
        self.bounce = bounce
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                if visible {
                    NavigationLink {
                        destination
                    } label: {
                        HStack {
                            if let icon {
                                Image(systemName: icon)
                            }
                            Text(title)
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .background(color)
                        .clipShape(Capsule())
                        .scaleEffect(bounce ? CGSize(width: 1.2, height: 1.2) : CGSize(width: 1, height: 1))
                    }.disabled(disabled)
                }
            }
        }
    }
}


