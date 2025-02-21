import SwiftUI

struct HomeScreen: View {
    @Environment(\.app)
    private var app

    @State var today: [Today] = []

    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("home_city_list_title")
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
            List {
                ForEach(today, id: \.self.name) { cityTodayForecast in
                    RoundedCellView(today: cityTodayForecast) { today in
                        app.navigation.push(to: .detail(weather: today))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .background(Color.background)

        }
        .background(Color.background)
        .onAppear() {
            getWeather()
        }
    }

    private func getWeather() {
        today = []
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
            today.append(contentsOf: results.sorted(by: { weather1, weather2 in
                weather1.name < weather2.name
            }))
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        Task {
            let citiesToDelete = offsets.map { today[$0] }
            for city in citiesToDelete {
                await app.repository.deleteCity(withName: city.name)
            }
            getWeather()
        }
    }
}

#Preview {
    VStack {
        HomeScreen()
    }
}
