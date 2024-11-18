struct Geocity: Codable {
        let name: String
        let localNames: LocalNames
        let lat: Double
        let lon: Double
        let country: String
        let state: String

        enum CodingKeys: String, CodingKey {
            case name
            case localNames = "local_names"
            case lat
            case lon
            case country
            case state
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
            localNames = try container.decodeIfPresent(LocalNames.self, forKey: .localNames) ?? LocalNames()
            lat = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0
            lon = try container.decodeIfPresent(Double.self, forKey: .lon) ?? 0
            country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
            state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
        }
}

struct LocalNames: Codable {
    let pl: String
    let de: String
    let es: String
    let lt: String
    let fr: String

    init() {
        pl = ""
        de = ""
        es = ""
        lt = ""
        fr = ""
    }
}
