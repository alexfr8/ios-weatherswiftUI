import SwiftUI

struct SplashScreen: View {
    @Environment(\.app)
    private var app

    var body: some View {
        VStack {
            Text("hello")
            Button("global_next") {
                app.navigation.push(to: .onboarding)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
