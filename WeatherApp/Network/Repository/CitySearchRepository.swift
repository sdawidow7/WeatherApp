import Foundation
protocol CitySearchRepository {
    func searchCities(with name: String) async throws -> [CityModel]
}

final class CitySearchRepositoryImpl: CitySearchRepository {
    func searchCities(with name: String) async throws -> [CityModel] {
        guard let nameWithPercentageEncoding = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { throw URLError.percentEncodingFailed }
        let baseUrl =  "https://dataservice.accuweather.com/locations/v1/cities/autocomplete" // TODO: Extract somewhere
        let apiKey = "c9HpcO2HBgbWm17kfyJRA86GcmJhAUN0" // TODO: Store in .plist
        let locale = "pl" // TODO: get from locale
        let cityNameUrl = "?apikey=\(apiKey)&q=\(nameWithPercentageEncoding)&language=\(locale)" // TODO: Create some builder to create URLs in more elegant way
        guard let url = URL(string: baseUrl + cityNameUrl) else { throw URLError.invalidURL }

        let (data, _) = try await URLSession.shared.data(from: url) // TODO: Handle HTTP Errors

        let cities = try JSONDecoder().decode([City].self, from: data)
        return cities.map { CityModel(cityId: $0.key, cityName: $0.name) }
    }
}

enum URLError: Error {
    case invalidURL
    case percentEncodingFailed
}
