import SwiftUI

struct HomeScreen: View {
    @Environment(\.app)
    private var app

    @State var today: [Today] = []

    var body: some View {
        VStack {
            Text("Hello, Home!")
            List(today, id: \.self.name) { cityTodayForecast in
                RoundedCellView(text: cityTodayForecast.name)
            }
            .background(Color.background)

        }
        .background(Color.background)
    }
}

#Preview {
    VStack {
        HomeScreen()
    }
}
