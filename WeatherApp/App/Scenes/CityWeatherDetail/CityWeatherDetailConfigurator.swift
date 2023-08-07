protocol CityWeatherDetailConfigurator {
    func defaultScene(with cityModelId: CityModelId) -> CityWeatherDetailViewController
}

final class CityWeatherDetailConfiguratorImpl: CityWeatherDetailConfigurator {
    func defaultScene(with cityModelId: CityModelId) -> CityWeatherDetailViewController {
        let viewModel = CityWeatherDetailViewModelImpl(cityModelId: cityModelId)
        return CityWeatherDetailViewController(viewModel: viewModel)
    }
}
