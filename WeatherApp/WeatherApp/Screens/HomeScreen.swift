import SwiftUI

struct HomeScreen: View {
    @Environment(\.app)
    private var app

    @State var today: [Today] = []

    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("Your city list")
                Spacer()
                Button {
                    app.navigation.present(to: .addCity) {
                        // TODO: Force refresh citys
                    }
                } label: {
                    Text("home_add_button")
                }

            }
            .padding(.horizontal, 8)
            List(today, id: \.self.name) { cityTodayForecast in
                RoundedCellView(today: cityTodayForecast)
            }
            .background(Color.background)

        }
        .background(Color.background)
        .onAppear() {
            getWeather()
        }
    }

    private func getWeather() {
        let client = app.openWeatherClient
        let repo = app.repository
        Task {
            let cities = await repo.getCities()
            var results: [Today] = []

            await withTaskGroup(of: Today?.self) { group in
                for city in cities {
                    group.addTask {
                        do {
                            let todayData = try await client.fetchToday(
                                lat: city.coord.lat,
                                long: city.coord.lon
                            )
                            return todayData
                        } catch {
                            return nil
                        }
                    }
                }

                for await todayData in group {
                    if let todayData = todayData {
                        results.append(todayData)
                    }
                }
            }
            today.append(contentsOf: results)
        }
    }
}

#Preview {
    VStack {
        HomeScreen()
    }
}
