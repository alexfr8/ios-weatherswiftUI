struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double

    init() {
        speed = 0
        deg = 0
        gust = 0
    }
}
