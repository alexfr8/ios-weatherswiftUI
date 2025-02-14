struct LocationData: Codable {
    let country: String
    let sunrise, sunset: Int

    init() {
        country = ""
        sunrise = 0
        sunset = 0
    }
}
