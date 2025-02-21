import CoreLocation
import SwiftUI

struct AddCityScreen: View {
    @Environment(\.app)
    private var app
    @Environment(\.dismiss)
    private var dismiss

    @State var cityName: String = ""
    @State var errorText: LocalizedStringKey?
    @State private var enableButton = false
    @State private var state: LoadingState = .idle
    @State private var cityList: [Geocity] = []

    // Definimos el enum para los estados
    private enum LoadingState: Equatable {
        case idle
        case loading
        case success
        case error(String)
    }

    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("add_city_title")
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 20, height: 20)
                }
            }

            BasicTextField(
                textValue: $cityName,
                hint: "add_city_field_hint",
                title: "add_city_field_title",
                errorSubtitle: errorText
            ) {

            }
            .padding(.vertical, 12)

            if !cityList.isEmpty {
                List(cityList, id: \.name) { city in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(city.name)
                            .font(.headline)
                            .foregroundColor(.text)
                        Text("\(city.state), \(city.country)")
                            .font(.subheadline)
                            .foregroundColor(.text)
                    }
                    .background(.listItemBackground)
                    .contentShape(Capsule())
                    .onTapGesture {
                        Task {
                            await storeCity(city: city)
                        }
                    }

                }
                .background(.clear)
                .listStyle(.plain)
            }

            Spacer()

            GenericButton("search_city_button", enabled: true) {
                Task {
                    await searchCityName(cityName: cityName)
                }
            }
            .padding(.vertical, 12)
        }
        .padding()
        .background(Color.background)
        .overlay {
            switch state {
            case .loading:
                ProgressView()
            case .idle, .success, .error:
                EmptyView()
            }
        }
        .task {
            addCityFromCurrentLocation()
        }
        .onChange(of: state) { _, newValue in
            if case .error(let message) = newValue {
                errorText = LocalizedStringKey(message)
            }
        }
    }

    private func validateTextField() -> Bool {
        enableButton == (cityName.count > 3)
    }

    func addCityFromCurrentLocation() {
        let locationManager =  CLLocationManager()
        Task {
            do {
                // Primero obtenemos la ubicación actual
                guard let location = locationManager.location else {
                    state = .error("No se pudo obtener la ubicación actual")
                    return
                }

                state = .loading

                // Obtenemos la ciudad y el clima
                let candidateCities = try await app.openWeatherClient.reverseGeocoding(
                    lat: location.coordinate.latitude,
                    long: location.coordinate.longitude
                )

                // Guardamos la ciudad en el repositorio
                //try await repository.saveCity(candidateCities.first)
                cityList.append(contentsOf: candidateCities)

                // Actualizamos el estado
                state = .success

                // Cerramos la pantalla
                dismiss()
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }

    private func searchCityName(cityName: String) async {
        if !cityName.isEmpty, cityName.count > 3 {
            do {
                state = .loading
                
                cityList = try await app.openWeatherClient.directGeocoding(name: cityName)
                
                state = .idle
            } catch {
                state = .error(error.localizedDescription)
                cityList = []
            }
        }
    }

    private func storeCity(city: Geocity) async {
        let repo = app.repository
        Task {
            var cities = await repo.getCities()
            cities.append(
                CityDomain(
                    id: UUID().uuidString,
                    name: city.name,
                    coord: CoordDomain(
                        long: city.lon,
                        lat: city.lat
                    ),
                    country: city.country
                )
            )
            await repo.setCities(cities: cities)
        }
    }
}

#Preview {
    VStack {
        AddCityScreen()
    }
}
