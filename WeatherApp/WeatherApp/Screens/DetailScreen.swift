import SwiftUI

struct DetailScreen: View {
    @Environment(\.app) private var app
    @Environment(\.dismiss) private var dismiss
    
    var weather: Today?
    @State private var city: Geocity?
    @State private var state: LoadingState = .idle

    @State private var forecast: Forecast5?

    private enum LoadingState: Equatable {
        case idle
        case loading
        case error(String)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if state == .loading {
                    skeletonView
                } else if let weather = weather {
                    VStack(spacing: 8) {
                        Image(systemName: getWeatherIcon(for: weather.weather.first?.main ?? "Clear"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)

                        Text(city?.name ?? "")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("\(city?.state ?? ""), \(city?.country ?? "")")
                            .font(.title3)
                            .foregroundColor(.gray)
                        
                        Text("\(Int(weather.main.temp))°")
                            .font(.system(size: 72))
                            .bold()
                        
                        Text(weather.weather.first?.description ?? "")
                            .font(.title2)

                        HStack(spacing: 8) {
                            Image(systemName: "sunrise.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)

                            Text(formatDate(Double(weather.sys.sunrise)))
                                .font(.system(size: 9))
                                .bold()

                            Spacer()

                            Text(formatDate(Double(weather.sys.sunset)))
                                .font(.system(size: 9))
                                .bold()

                            Image(systemName: "sunset.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                        .padding(.horizontal, 16)

                        HStack(spacing: 8) {
                            VStack(spacing: 8) {
                                Text("detail_wind_information")
                                    .font(.footnote)
                                    .bold()
                                    .padding(.bottom, 8)

                                Spacer()

                                Image(systemName: getArrowImageName(for: weather.wind.deg))
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.bottom, 16)
                                    .frame(width: 40, height: 40)

                                Text(getCardinalDirection(for: weather.wind.deg))
                                    .font(.system(size: 24))


                                Text(convertSpeed(weather.wind.speed))
                                    .font(.system(size: 24))
                            }
                            .overlay(alignment: .topLeading) {
                                Image(systemName: "wind")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                            }
                            .frame(width: 150, height: 150)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)

                            VStack(spacing: 8) {
                                Text("detail_extra_information")
                                    .font(.footnote)
                                    .bold()
                                    .padding(.bottom, 8)

                                Spacer()

                                HStack{
                                    Text("detail_humidity_title")
                                        .font(.system(size: 14))

                                    Spacer()

                                    Text("\(String(describing: weather.main.humidity)) %")
                                        .font(.system(size: 16))
                                }

                                HStack{
                                    Text("detail_feelslike_title")
                                        .font(.system(size: 14))

                                    Spacer()

                                    Text("\(String(describing: weather.main.feelsLike)) º")
                                        .font(.system(size: 16))
                                }

                                HStack{
                                    Text("detail_min_title")
                                        .font(.system(size: 14))

                                    Spacer()

                                    Text("\(String(describing: weather.main.tempMin)) º")
                                        .font(.system(size: 16))
                                }

                                HStack{
                                    Text("detail_max_title")
                                        .font(.system(size: 14))

                                    Spacer()

                                    Text("\(String(describing: weather.main.tempMax)) º")
                                        .font(.system(size: 16))
                                }
                            }
                            .overlay(alignment: .topLeading) {
                                Image(systemName: "info.bubble")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                            }
                            .frame(width: 150, height: 150)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)


                        }

                        HStack(spacing: 8) {
                            Image(systemName: "cloud.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)

                            Text("detail_clouds_information")
                                .font(.footnote)
                                .bold()
                                .padding(.bottom, 8)

                            Spacer()

                            Text("\(weather.clouds.all) %")
                                .font(.system(size: 24))
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 24)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    // Forecast section
                    if let forecast = forecast {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("detail_5_days_forecast_title")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(forecast.list, id: \.dt) { day in
                                        VStack(spacing: 8) {
                                            Text(formatDate(Double(day.dt)))
                                                .font(.system(size: 9))
                                                .bold()
                                            
                                            Image(systemName: getWeatherIcon(for: day.weather.first?.main ?? "Clear"))
                                                .font(.system(size: 24))

                                            Text("\(Int(day.main.temp))°")
                                                .font(.title3)
                                                .bold()
                                            
                                            HStack(spacing: 4) {
//                                                Text("↑\(Int(day.main.temp_max))°")
//                                                    .foregroundColor(.red)
//                                                Text("↓\(Int(day.main.temp_min))°")
//                                                    .foregroundColor(.blue)
                                            }
                                            .font(.caption)
                                            
                                            Text(day.weather.first?.description.capitalized ?? "")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                                .multilineTextAlignment(.center)
                                        }
                                        .frame(width: 100)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .task {
            await loadForecast()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("detail_back") {
                    dismiss()
                }
            }
        }
    }

    @ViewBuilder
    private var skeletonView: some View {
        VStack(spacing: 16) {
            // Skeleton para el nombre de la ciudad
            SkeletonView()
                .frame(width: 200, height: 40)
            
            // Skeleton para estado y país
            SkeletonView()
                .frame(width: 150, height: 25)
            
            // Skeleton para temperatura
            SkeletonView()
                .frame(width: 120, height: 80)
            
            // Skeleton para descripción
            SkeletonView()
                .frame(width: 180, height: 30)
            
            // Skeleton para pronóstico
            VStack(alignment: .leading, spacing: 12) {
                SkeletonView()
                    .frame(width: 150, height: 30)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<5) { _ in
                            VStack(spacing: 8) {
                                SkeletonView()
                                    .frame(width: 80, height: 20)
                                
                                SkeletonView()
                                    .frame(width: 40, height: 40)
                                
                                SkeletonView()
                                    .frame(width: 60, height: 25)
                                
                                SkeletonView()
                                    .frame(width: 80, height: 20)
                                
                                SkeletonView()
                                    .frame(width: 80, height: 20)
                            }
                            .frame(width: 100)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding()
    }

    private func loadForecast() async {
        guard let coord = weather?.coord else { return }
        state = .loading
        let client = app.openWeatherClient
        do {
            forecast = try await client.fetchForecast(lat: coord.lat, long: coord.lon)
            state = .idle
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    private func formatDate(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM, HH"
        return formatter.string(from: date) + " hrs"
    }

    func convertSpeed(_ velocityMS: Double?) -> String {
        guard let velocity = velocityMS else {
            return "No value"
        }

        let velocityKMH = velocity * 3.6
        return String(format: "%.2f Km/h", velocityKMH)
    }

    func getArrowImageName(for angle: Int?) -> String {
        guard let angle = angle else {
            return "questionmark"
        }

        switch angle {
        case 337...360, 0..<22:
            return "arrow.up"
        case 22..<67:
            return "arrow.up.right"
        case 67..<112:
            return "arrow.right"
        case 112..<157:
            return "arrow.down.right"
        case 157..<202:
            return "arrow.down"
        case 202..<247:
            return "arrow.down.left"
        case 247..<292:
            return "arrow.left"
        case 292..<337:
            return "arrow.up.left"
        default:
            return "questionmark"
        }
    }

    func getCardinalDirection(for angle: Int?) -> String {
        guard let angle = angle else {
            return "?"
        }

        switch angle {
        case 337...360, 0..<22:
            return String(localized: "detail_nort")
        case 22..<67:
            return String(localized: "detail_nort_east")
        case 67..<112:
            return String(localized: "detail_east")
        case 112..<157:
            return String(localized: "detail_south_east")
        case 157..<202:
            return String(localized: "detail_south")
        case 202..<247:
            return String(localized: "detail_south_west")
        case 247..<292:
            return String(localized: "detail_west")
        case 292..<337:
            return String(localized: "detail_nort_west")
        default:
            return "?"
        }
    }

    private func getWeatherIcon(for main: String) -> String {
        switch main {
        case "Clear": return "sun.max.fill"
        case "Clouds": return "cloud.fill"
        case "Rain": return "cloud.rain.fill"
        case "Snow": return "snow"
        case "Thunderstorm": return "cloud.bolt.fill"
        case "Fog": return "cloud.fog.fill"
        case "Mist": return "cloud.fog.fill"
        default: return "questionmark.circle.fill"
        }
    }
} 
