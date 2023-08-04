final class SelectCityConfigurator {

    func defaultScene() -> SelectCityViewController {
        let viewModel = SelectCityViewModelImpl(useCase: SelectCityUseCaseImpl(), router: SelectCityRouterImpl())
        return SelectCityViewController(viewModel: viewModel)
    }
}
