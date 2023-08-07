import UIKit

protocol SelectCityRouter {
    func showCityDetails(for cityModel: CityModel)
}

final class SelectCityRouterImpl: SelectCityRouter {

    private let weatherDetailConfigurator: CityWeatherDetailConfigurator

    init(weatherDetailConfigurator: CityWeatherDetailConfigurator) {
        self.weatherDetailConfigurator = weatherDetailConfigurator
    }

    weak var viewController: UIViewController?
    func showCityDetails(for cityModel: CityModel) {
        let weatherDetailViewController = weatherDetailConfigurator.defaultScene(with: cityModel)
        viewController?.navigationController?.show(weatherDetailViewController, sender: nil)
    }
}
