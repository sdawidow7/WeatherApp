final class SelectCityConfigurator {

    func defaultScene() -> SelectCityViewController {
        let viewModel = SelectCityViewModelImpl()
        return SelectCityViewController(viewModel: viewModel)
    }
}
