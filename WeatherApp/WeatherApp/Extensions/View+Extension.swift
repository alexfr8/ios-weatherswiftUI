import SwiftUI

extension View {

    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }

    func hideNavigationBar() -> some View {
        navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }

    func getSafeArea() -> UIEdgeInsets {
        guard
            let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let safeArea = screen.windows.first?.safeAreaInsets
        else {
            return .zero
        }
        return safeArea
    }

    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }

    func hideKeyboard() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    func loading(isPresented: Binding<Bool>) -> some View {
        fullScreenCover(isPresented: isPresented) {
            LoadingView()
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }

    @ViewBuilder
    func ifLet<Value, Content: View>(
        _ value: Value?,
        transform: (Self, Value) -> Content
    ) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
}

/// See https://www.devtechie.com/community/public/posts/151937-round-specific-corners-in-swiftui
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
