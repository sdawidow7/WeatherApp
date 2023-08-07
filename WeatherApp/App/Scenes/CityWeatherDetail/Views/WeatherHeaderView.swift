import UIKit

final class WeatherHeaderView: UIView {

    let cityLabel = UILabel()
    let iconImageView = UIImageView()
    let temperatureLabel = UILabel()
    let descriptionLabel = UILabel()

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
        addSubview(cityLabel)
        addSubview(iconImageView)
        addSubview(temperatureLabel)
        addSubview(descriptionLabel)
    }

    func setUpProperties() {
        cityLabel.numberOfLines = 2
        cityLabel.font = .systemFont(ofSize: 24)

        iconImageView.backgroundColor = .red

        temperatureLabel.font = .boldSystemFont(ofSize: 36)
    }

    func setUpConstraints() {
        [cityLabel, iconImageView, temperatureLabel, descriptionLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: Constant.horizontalMargin),
            cityLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -Constant.horizontalMargin),
            cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constant.verticalSpacing),
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            iconImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: Constant.verticalSpacing),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: Constant.IconImageView.size.height),
            iconImageView.widthAnchor.constraint(equalToConstant: Constant.IconImageView.size.width),

            temperatureLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: Constant.verticalSpacing),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Constant.verticalSpacing),
            descriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: Constant.horizontalMargin),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -Constant.horizontalMargin),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.verticalSpacing)
        ])
    }

    private enum Constant {
        static let verticalSpacing: CGFloat = 8
        static let horizontalMargin: CGFloat = 16

        enum IconImageView {
            static let size: CGSize = .init(width: 64, height: 64)
        }
    }
}
