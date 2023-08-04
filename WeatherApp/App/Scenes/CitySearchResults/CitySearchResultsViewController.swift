import UIKit
import Combine

protocol CitySearchResultsDisplayLogic: UIViewController {
    func update(with list: [CityModel], animated: Bool)
    var selectionPublisher: AnyPublisher<CityModelId, Never> { get }
}

final class CitySearchResultsViewController: UIViewController, CitySearchResultsDisplayLogic {
    var selectionPublisher: AnyPublisher<CityModelId, Never> = PassthroughSubject<CityModelId, Never>().eraseToAnyPublisher()

    func update(with list: [CityModel], animated: Bool = true) {
        // TODO: Implement
    }
}
