import Foundation

protocol CityWeatherDetailViewModel {
    // TODO: Implement
}

final class CityWeatherDetailViewModelImpl: CityWeatherDetailViewModel { // TODO: Implement

    private let cityModelId: CityModelId

    init(cityModelId: CityModelId) {
        self.cityModelId = cityModelId
    }
}
