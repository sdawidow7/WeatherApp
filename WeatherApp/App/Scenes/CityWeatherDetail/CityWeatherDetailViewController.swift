import UIKit

final class CityWeatherDetailViewController: UIViewController {

    private lazy var mainView = CityWeatherDetailView()

    init() {
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
