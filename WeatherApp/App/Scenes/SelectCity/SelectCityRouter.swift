protocol SelectCityRouter {
    func showCityDetails(for cityId: CityModelId)
}

final class SelectCityRouterImpl: SelectCityRouter {
    func showCityDetails(for cityId: CityModelId) {
        print("NAVIGATE TO CITY: \(cityId)") // TODO: Implement
    }
}
