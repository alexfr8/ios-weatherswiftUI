import SwiftUI

struct RoundedCellView: View {
    let today: Today
    let action: (Today) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(today.name)
                    .font(.headline)
                Text("\(today.main.temp, specifier: "%.1f")°C")
                    .font(.subheadline)
                Text(today.weather.first?.description.capitalized ?? "N/A")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            // Icono del clima
            Image(systemName: getWeatherIcon(for: today.weather.first?.main ?? "Clear"))
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action(today)
        }
    }

    func getWeatherIcon(for main: String) -> String {
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

#Preview {
    let today = Today()
    VStack {
        RoundedCellView(today: today) { selectedToday in
            print("Celda tocada con ciudad: \(selectedToday.name)")
        }
    }
}
