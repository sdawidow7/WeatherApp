final class SelectCityConfigurator {

    private let citySearchRepository: CitySearchRepository // Not needed with some DI - simplified to passing on init

    init(citySearchRepository: CitySearchRepository) {
        self.citySearchRepository = citySearchRepository
    }

    func defaultScene() -> SelectCityViewController {
        let useCase = SelectCityUseCaseImpl(citySearchRepository: citySearchRepository)
        let router = SelectCityRouterImpl()
        let viewModel = SelectCityViewModelImpl(useCase: useCase, router: router)
        return SelectCityViewController(viewModel: viewModel, citySearchViewController: CitySearchResultsViewController())
    }
}
