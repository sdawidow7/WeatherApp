typealias WeatherIconId = Int
struct CurrentWeatherModel: Equatable {
    let iconId: WeatherIconId
    let description: String
    let temperature: TemperatureModel
}

struct TemperatureModel: Equatable {
    let value: Double
    let unit: String
}
