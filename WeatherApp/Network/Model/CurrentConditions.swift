struct CurrentConditions: Codable, Equatable {
    let weatherIcon: Int
    let weatherText: String
    let temperature: Temperature

    enum CodingKeys: String, CodingKey {
        case weatherIcon = "WeatherIcon"
        case weatherText = "WeatherText"
        case temperature = "Temperature"
    }
}

struct Temperature: Codable, Equatable {
    let metric: TemperatureUnitInfo
    let imperial: TemperatureUnitInfo

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

struct TemperatureUnitInfo: Codable, Equatable {
    let value: Double
    let unit: String

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}
