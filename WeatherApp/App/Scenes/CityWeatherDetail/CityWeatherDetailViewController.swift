import UIKit
import Combine

final class CityWeatherDetailViewController: UIViewController {

    private lazy var mainView = CityWeatherDetailView()
    private let viewModel: CityWeatherDetailViewModel

    private let appearSubject: PassthroughSubject<Void, Never>
    private var cancellables: [AnyCancellable] = []

    init(viewModel: CityWeatherDetailViewModel,
         appearSubject: PassthroughSubject<Void, Never>) {
        self.viewModel = viewModel
        self.appearSubject = appearSubject
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appearSubject.send()
    }

    // MARK: - Private

    private func bind(to viewModel: CityWeatherDetailViewModel) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        let input = CityWeatherDetailViewModelInput(appearPublisher: appearSubject.eraseToAnyPublisher())
        let output = viewModel.bind(input: input)
        output.sink { [unowned self] state in
            self.render(state)
        }.store(in: &cancellables)
    }

    @MainActor
    private func render(_ state: CityWeatherDetailState) {
        switch state {
        case let .success(currentWeather):
            DispatchQueue.main.async { [weak self] in
                self?.configureViewSuccess(with: currentWeather)
            }
        case .failure, .loading: // TODO: Handle other states
            break
        }
    }

    private func configureViewSuccess(with currentWeather: CityWeatherDetailDisplayModel) {
        mainView.cityName = currentWeather.cityName
        mainView.temperatureLabel.text = "\(currentWeather.temperature)°\(currentWeather.temperatureUnit)"
        mainView.temperatureLabel.textColor = currentWeather.temperatureRange.color
        mainView.weatherDescription = currentWeather.description
    }
}

extension CityWeatherDetailViewController {
    convenience init(viewModel: CityWeatherDetailViewModel) {
        self.init(viewModel: viewModel, appearSubject: .init())
    }
}

struct CityWeatherDetailDisplayModel: Equatable {
    let cityName: String
    let iconId: WeatherIconId
    let temperature: Int
    let temperatureUnit: String
    let temperatureRange: TemperatureRangeModel
    let description: String
}

extension TemperatureRangeModel {
    var color: UIColor {
        switch self {
        case .cold: return .blue
        case .normal: return .black
        case .hot: return .red
        }
    }
}
