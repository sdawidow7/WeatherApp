protocol CityWeatherDetailConfigurator {
    func defaultScene(with cityModelId: CityModelId) -> CityWeatherDetailViewController
}

final class CityWeatherDetailConfiguratorImpl: CityWeatherDetailConfigurator {
    func defaultScene(with cityModelId: CityModelId) -> CityWeatherDetailViewController {
        let useCase = CurrentWeatherUseCaseImpl()
        let viewModel = CityWeatherDetailViewModelImpl(cityModelId: cityModelId, useCase: useCase)
        return CityWeatherDetailViewController(viewModel: viewModel)
    }
}
