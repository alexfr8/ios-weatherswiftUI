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
}
