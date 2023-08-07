import Combine

typealias CurrentWeatherResult = Result<[CurrentWeatherModel], Error>

protocol CurrentWeatherUseCase {
    func currentWeather(for cityModelId: CityModelId) -> AnyPublisher<CurrentWeatherModel, Never>
}

final class CurrentWeatherUseCaseImpl: CurrentWeatherUseCase {

    private let unitsType: UnitsType = .metrics // TODO: store and resolve from some worker

    func currentWeather(for cityModelId: CityModelId) -> AnyPublisher<CurrentWeatherModel, Never> {

    }
}



