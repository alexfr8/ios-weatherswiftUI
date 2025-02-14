struct Today: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: TempData
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: LocationData
    let timezone, id: Int
    let name: String
    let cod: Int

    init() {
        coord = Coord()
        weather = []
        base = ""
        main = TempData()
        visibility = 0
        wind = Wind()
        clouds = Clouds()
        dt = 0
        sys = LocationData()
        timezone = 0
        id = 0
        name = "Empty"
        cod = 45
    }
}
