struct Forecast: Codable {
    let dt: Int
    let main: TempData
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case visibility
        case pop
        case dtTxt = "dt_txt"
        case rain
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        dt = try container.decodeIfPresent(Int.self, forKey: .dt) ?? 0
        main = try container.decodeIfPresent(TempData.self, forKey: .main) ?? TempData()
        weather = try container.decodeIfPresent([Weather].self, forKey: .weather) ?? []
        clouds = try container.decodeIfPresent(Clouds.self, forKey: .clouds) ?? Clouds()
        wind = try container.decodeIfPresent(Wind.self, forKey: .wind) ?? Wind()
        visibility = try container.decodeIfPresent(Int.self, forKey: .visibility) ?? 0
        pop = try container.decodeIfPresent(Double.self, forKey: .pop) ?? 0
        dtTxt = try container.decodeIfPresent(String.self, forKey: .dtTxt) ?? ""
        rain = try container.decodeIfPresent(Rain.self, forKey: .rain) ?? Rain()
    }
}
