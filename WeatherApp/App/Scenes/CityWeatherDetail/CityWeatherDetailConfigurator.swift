final class CityWeatherDetailConfigurator {
    func defaultScene(with cityModelId: CityModelId) -> CityWeatherDetailViewController {
        let viewModel = CityWeatherDetailViewModelImpl(cityModelId: cityModelId)
        return CityWeatherDetailViewController(viewModel: viewModel)
    }
}
