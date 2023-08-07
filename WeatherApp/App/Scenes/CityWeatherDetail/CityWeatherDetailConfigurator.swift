protocol CityWeatherDetailConfigurator {
    func defaultScene(with cityModel: CityModel) -> CityWeatherDetailViewController
}

final class CityWeatherDetailConfiguratorImpl: CityWeatherDetailConfigurator {
    func defaultScene(with cityModel: CityModel) -> CityWeatherDetailViewController {
        let useCase = CurrentWeatherUseCaseImpl()
        let viewModel = CityWeatherDetailViewModelImpl(cityModel: cityModel, useCase: useCase)
        return CityWeatherDetailViewController(viewModel: viewModel)
    }
}
