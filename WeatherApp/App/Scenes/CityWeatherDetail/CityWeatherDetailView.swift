import UIKit

final class CityWeatherDetailView: UIView {

    var cityName: String? {
        get { headerView.cityLabel.text }
        set { headerView.cityLabel.text = newValue }
    }

    var temperatureLabel: UILabel {
        headerView.temperatureLabel
    }

    var weatherDescription: String? {
        get { headerView.descriptionLabel.text }
        set { headerView.descriptionLabel.text = newValue }
    }

    private let headerView = WeatherHeaderView()

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Private

    private func commonInit() {
        setUpSubviews()
        setUpProperties()
        setUpConstraints()
    }

    func setUpSubviews() {
        addSubview(headerView)
    }

    func setUpProperties() {
        backgroundColor = .white
    }

    func setUpConstraints() {
        [headerView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
