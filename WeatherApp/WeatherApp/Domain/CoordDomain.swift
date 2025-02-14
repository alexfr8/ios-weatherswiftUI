struct CoordDomain: Codable {
    let lon, lat: Double

    init(long: Double, lat: Double) {
        lon = long
        self.lat = lat
    }

    init() {
        lon = 0
        lat = 0
    }
}
