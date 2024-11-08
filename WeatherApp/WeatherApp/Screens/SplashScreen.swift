import SwiftUI

struct SplashScreen: View {
    @Environment(\.app)
    private var app

    var body: some View {
        VStack {
            Text("splash_screen_title")
                .padding(.horizontal, 6)
                .padding(.top, 12)

            Spacer()

            Image(.splash)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .padding(12)
                .padding(6)

            Spacer()

            ProgressView {
                Text(verbatim: "Loading")
            }
            .padding()
            .background(Color.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .tint(.gray)
            .foregroundColor(.white)
        }
        .task {
            await startAppFlow()
        }
    }

    private func startAppFlow() async {
        if await app.repository.getFirstTimeRun() {
            app.navigation.push(to: .home)
        } else {
            await app.repository.setFirstTimeRun(true)
            app.navigation.push(to: .onboarding)
        }
    }
}

#Preview {
    SplashScreen()
}
