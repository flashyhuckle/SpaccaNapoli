import SwiftUI

enum CustomAlertConfiguration {
    case oneButton
    case twoButton
}

struct CustomAlertView: View {
    @Binding private var isPresented: Bool
    @State private var titleKey: LocalizedStringKey
    @State private var messageKey: LocalizedStringKey
    
    @State private var configuration: CustomAlertConfiguration
    
    @State private var actionTextKey: LocalizedStringKey
    
    @State private var isAnimating = false
    private let animationDuration = 0.25

    private var action: (() -> ())?
    private var cancelAction: (() -> ())?
    
    init(
        titleKey: LocalizedStringKey,
        messageKey: LocalizedStringKey,
        isPresented: Binding<Bool>,
        configuration: CustomAlertConfiguration,
        actionTextKey: LocalizedStringKey,
        action: @escaping () -> (),
        cancelAction: @escaping () -> ()
    ) {
        _titleKey = State(wrappedValue: titleKey)
        _messageKey = State(wrappedValue: messageKey)
        _isPresented = isPresented
        _configuration = State(wrappedValue: configuration)
        _actionTextKey = State(wrappedValue: actionTextKey)
        
        self.action = action
        self.cancelAction = cancelAction
    }
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
                .opacity(isPresented ? 0.6 : 0)
                .zIndex(1)
            
            if isAnimating {
                VStack {
                    Text(titleKey)
                        .font(.title2).bold()
                        .foregroundStyle(.green)
                        .padding(8)
                        .multilineTextAlignment(.center)
                    
                    Text(messageKey)
                        .foregroundStyle(.green)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        if configuration == .twoButton {
                            CancelButton
                        }
                        DoneButton
                    }
                    .padding()
                }
                .padding()
                .frame(maxWidth: 250)
                .background(.background)
                .cornerRadius(35)
                .transition(.opacity)
                .zIndex(2)
            }
                
        }
        .ignoresSafeArea()
        .onAppear {
            show()
        }
    }
    
    var DoneButton: some View {
        Button {
            dismiss()
            action?()
        } label: {
            Text(actionTextKey)
                .font(.headline).bold()
                .foregroundStyle(Color.white)
                .padding()
                .multilineTextAlignment(.center)
                .frame(maxWidth: 125)
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    var CancelButton: some View {
        Button {
            dismiss()
            cancelAction?()
            
        } label: {
            Text("Cancel")
                .font(.headline)
                .foregroundStyle(.red)
                .padding()
                .lineLimit(1)
                .frame(maxWidth: 125)
                .background(Material.regular)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }

    func dismiss() {
        if #available(iOS 17.0, *) {
            withAnimation(.easeInOut(duration: animationDuration)) {
                isAnimating = false
            } completion: {
                isPresented = false
            }
        } else {
            withAnimation(.easeInOut(duration: animationDuration)) {
                isAnimating = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                isPresented = false
            }
        }
    }

    func show() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            isAnimating = true
        }
    }
}

extension View {
    func oneButtonAlert(
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        isPresented: Binding<Bool>,
        action: @escaping () -> ()
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            CustomAlertView(
                titleKey: title,
                messageKey: message,
                isPresented: isPresented,
                configuration: .oneButton,
                actionTextKey: "Ok",
                action: action,
                cancelAction: action
            )
            .presentationBackground(.clear)
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
}


#Preview {
    //OneButton Preview
    CustomAlertView(
        titleKey: "Your request is sent",
        messageKey: "Your reservation for 20/05/2024 12:00 for 12 has been requested. Please wait for a confirmation.",
        isPresented: .constant(true),
        configuration: .oneButton,
        actionTextKey: "Ok",
        action: {},
        cancelAction: {}
    )
    
    //TwoButton Preview
//    CustomAlertView(
//        titleKey: "Request sent",
//        messageKey: "Your reservation for 20/05/2024 12:00 for 12 has been requested. Please wait for a confirmation.",
//        isPresented: .constant(true),
//        configuration: .twoButton,
//        actionTextKey: "Ok",
//        action: {},
//        cancelAction: {}
//    )
}
