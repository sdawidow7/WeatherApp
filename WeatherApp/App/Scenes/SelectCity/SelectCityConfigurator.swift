final class SelectCityConfigurator {

    func defaultScene() -> SelectCityViewController {
        let useCase = SelectCityUseCaseImpl()
        let router = SelectCityRouterImpl()
        let viewModel = SelectCityViewModelImpl(useCase: useCase, router: router)
        return SelectCityViewController(viewModel: viewModel, citySearchViewController: CitySearchResultsViewController())
    }
}
