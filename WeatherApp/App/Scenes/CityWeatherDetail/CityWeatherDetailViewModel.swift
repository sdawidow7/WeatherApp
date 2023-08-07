import Foundation
import Combine

protocol CityWeatherDetailViewModel {
    func bind(input: CityWeatherDetailViewModelInput) -> CityWeatherDetailOutput
}

final class CityWeatherDetailViewModelImpl: CityWeatherDetailViewModel {

    private let cityModel: CityModel
    private let useCase: CurrentWeatherUseCase
    private var cancellables: [AnyCancellable] = []

    init(cityModel: CityModel,
         useCase: CurrentWeatherUseCase) {
        self.cityModel = cityModel
        self.useCase = useCase
    }

    func bind(input: CityWeatherDetailViewModelInput) -> CityWeatherDetailOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        let loadingState = Just<CityWeatherDetailState>(.loading).eraseToAnyPublisher()

        let weather = useCase.currentWeather(for: cityModel.cityId)
            .map { [unowned self] result -> CityWeatherDetailState in
                switch result {
                case let .success(weather):
                    return .success(self.displayModel(from: weather))
                case .failure:
                    return .failure
                }
            }
            .eraseToAnyPublisher()

        return Publishers.Merge(loadingState, weather).eraseToAnyPublisher()
    }

    // MARK: - Private

    private func displayModel(from model: CurrentWeatherModel) -> CityWeatherDetailDisplayModel {
        let temperature = Int(model.temperature.value)
        return .init(cityName: cityModel.cityName,
                     iconId: model.iconId,
                     temperature: temperature,
                     temperatureUnit: model.temperature.unit,
                     temperatureRange: .init(temperature),
                     description: model.description)
    }
}

struct CityWeatherDetailViewModelInput {
    let appearPublisher: AnyPublisher<Void, Never>
}

typealias CityWeatherDetailOutput = AnyPublisher<CityWeatherDetailState, Never>

enum CityWeatherDetailState: Equatable {
    case loading
    case success(CityWeatherDetailDisplayModel)
    case failure
}

enum TemperatureRangeModel: Equatable {
    case hot
    case normal
    case cold

    init(_ temperature: Int) {
        if temperature < 10 { self = .cold }
        else if temperature > 20 { self = .hot }
        else { self = .normal }
    }
}
