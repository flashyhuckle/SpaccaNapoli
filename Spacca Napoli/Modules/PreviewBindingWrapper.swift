import SwiftUI

public struct PreviewBindingWrapper<T, Content: View>: View {
    @State private var wrappedBinding: T
    private let content: (Binding<T>) -> Content

    public init(wrappedBinding: T, @ViewBuilder content: @escaping (Binding<T>) -> Content) {
        self._wrappedBinding = State(wrappedValue: wrappedBinding)
        self.content = content
    }

    public var body: some View {
        content($wrappedBinding)
    }
}

public struct PreviewBindingWrapperDouble<T, A, Content: View>: View {
    @State private var wrappedBinding1: T
    @State private var wrappedBinding2: A
    private let content: (Binding<T>, Binding<A>) -> Content

    public init(_ wrappedBinding1: T, _ wrappedBinding2: A, @ViewBuilder content: @escaping (Binding<T>, Binding<A>) -> Content) {
        self._wrappedBinding1 = State(wrappedValue: wrappedBinding1)
        self._wrappedBinding2 = State(wrappedValue: wrappedBinding2)
        self.content = content
    }

    public var body: some View {
        content($wrappedBinding1, $wrappedBinding2)
    }
}
