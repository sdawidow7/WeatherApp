import UIKit

final class CityWeatherDetailViewController: UIViewController {

    private lazy var mainView = CityWeatherDetailView()
    private let viewModel: CityWeatherDetailViewModel

    init(viewModel: CityWeatherDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = mainView
    }
}
