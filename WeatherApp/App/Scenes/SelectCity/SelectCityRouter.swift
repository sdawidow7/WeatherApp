import UIKit

protocol SelectCityRouter {
    func showCityDetails(for cityId: CityModelId)
}

final class SelectCityRouterImpl: SelectCityRouter {

    private let weatherDetailConfigurator: CityWeatherDetailConfigurator

    init(weatherDetailConfigurator: CityWeatherDetailConfigurator) {
        self.weatherDetailConfigurator = weatherDetailConfigurator
    }

    weak var viewController: UIViewController?
    func showCityDetails(for cityId: CityModelId) {
        let weatherDetailViewController = weatherDetailConfigurator.defaultScene(with: cityId)
        viewController?.navigationController?.show(weatherDetailViewController, sender: nil)
        print("NAVIGATE TO CITY: \(cityId)") // TODO: Implement
    }
}
