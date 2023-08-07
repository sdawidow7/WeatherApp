import Foundation
import Combine

protocol CityWeatherDetailViewModel {
    func bind(input: CityWeatherDetailViewModelInput) -> CityWeatherDetailOutput
}

final class CityWeatherDetailViewModelImpl: CityWeatherDetailViewModel {

    private let cityModelId: CityModelId
    private let useCase: CurrentWeatherUseCase
    private var cancellables: [AnyCancellable] = []

    init(cityModelId: CityModelId,
         useCase: CurrentWeatherUseCase) {
        self.cityModelId = cityModelId
        self.useCase = useCase
    }

    func bind(input: CityWeatherDetailViewModelInput) -> CityWeatherDetailOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        let loadingState = Just<CityWeatherDetailState>(.loading).eraseToAnyPublisher()

        let weather = useCase.currentWeather(for: cityModelId)
            .map { result -> CityWeatherDetailState in
                switch result {
                case let .success(weather):
                    return .success(weather)
                case .failure:
                    return .failure
                }
            }
            .eraseToAnyPublisher()

        return Publishers.Merge(loadingState, weather).eraseToAnyPublisher()
    }
}

struct CityWeatherDetailViewModelInput {
    let appearPublisher: AnyPublisher<Void, Never>
}

typealias CityWeatherDetailOutput = AnyPublisher<CityWeatherDetailState, Never>

enum CityWeatherDetailState: Equatable {
    case loading
    case success(CurrentWeatherModel)
    case failure
}
