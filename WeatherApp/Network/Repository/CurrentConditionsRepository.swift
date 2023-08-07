import Foundation

protocol CurrentConditionsRepository {
    func getCurrentConditions(for cityId: CityKey) async throws -> CurrentConditions
}

final class CurrentConditionsRepositoryImpl: CurrentConditionsRepository {
    func getCurrentConditions(for cityId: CityKey) async throws -> CurrentConditions {
        let baseUrl =  "https://dataservice.accuweather.com" // TODO: Extract somewhere
        let apiKey = "c9HpcO2HBgbWm17kfyJRA86GcmJhAUN0" // TODO: Store in .plist
        let currentConditionsUrlString = "/currentconditions/v1/"
        let locale = "pl" // TODO: get from locale
        let suffixUrl = "\(currentConditionsUrlString)/\(cityId)?apikey=\(apiKey)&language=\(locale)&details=false" // TODO: Create some builder to create URLs in more elegant way
        guard let url = URL(string: baseUrl + suffixUrl) else { throw URLError.invalidURL }

        let (data, _) = try await URLSession.shared.data(from: url) // TODO: Handle HTTP Errors

        let currentConditions = try JSONDecoder().decode([CurrentConditions].self, from: data)
        guard let currentCondition = currentConditions.first else { throw CurrentConditionsError.emptyResponse }

        return currentCondition
    }
}

enum CurrentConditionsError: Error {
    case emptyResponse
}
