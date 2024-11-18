struct Rain: Codable {
    let the3h: Double

    enum CodingKeys: String, CodingKey {
        case the3h = "3h"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        the3h = try container.decodeIfPresent(Double.self, forKey: .the3h) ?? 0
    }
    init() {
        the3h = 0
    }
}
