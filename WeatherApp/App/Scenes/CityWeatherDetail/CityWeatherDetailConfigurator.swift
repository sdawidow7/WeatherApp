protocol CityWeatherDetailConfigurator {
    func defaultScene(with cityModel: CityModel) -> CityWeatherDetailViewController
}

final class CityWeatherDetailConfiguratorImpl: CityWeatherDetailConfigurator {

    private let currentConditionsRepository: CurrentConditionsRepository

    init(currentConditionsRepository: CurrentConditionsRepository) {
        self.currentConditionsRepository = currentConditionsRepository
    }

    func defaultScene(with cityModel: CityModel) -> CityWeatherDetailViewController {
        let useCase = CurrentWeatherUseCaseImpl(currentConditionsRepository: currentConditionsRepository)
        let viewModel = CityWeatherDetailViewModelImpl(cityModel: cityModel, useCase: useCase)
        return CityWeatherDetailViewController(viewModel: viewModel)
    }
}
