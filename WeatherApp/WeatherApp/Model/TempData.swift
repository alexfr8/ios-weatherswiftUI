struct TempData: Codable {
    let temp, feelsLike, tempMin, tempMax, tempKf: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempKf
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_levl"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        temp = try container.decodeIfPresent(Double.self, forKey: .temp) ?? 0
        feelsLike = try container.decodeIfPresent(Double.self, forKey: .feelsLike) ?? 0
        tempMin = try container.decodeIfPresent(Double.self, forKey: .tempMin) ?? 0
        tempMax = try container.decodeIfPresent(Double.self, forKey: .tempMax) ?? 0
        tempKf = try container.decodeIfPresent(Double.self, forKey: .tempKf) ?? 0
        pressure = try container.decodeIfPresent(Int.self, forKey: .pressure) ?? 0
        humidity = try container.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
        seaLevel = try container.decodeIfPresent(Int.self, forKey: .seaLevel) ?? 0
        grndLevel = try container.decodeIfPresent(Int.self, forKey: .grndLevel) ?? 0
    }

    init() {
        temp = 0
        feelsLike = 0
        tempMin = 0
        tempMax = 0
        tempKf = 0
        pressure = 0
        humidity = 0
        seaLevel = 0
        grndLevel = 0
    }
}
