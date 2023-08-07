import Combine

typealias CurrentWeatherResult = Result<CurrentWeatherModel, Error>

protocol CurrentWeatherUseCase {
    func currentWeather(for cityModelId: CityModelId) -> AnyPublisher<CurrentWeatherResult, Never>
}

final class CurrentWeatherUseCaseImpl: CurrentWeatherUseCase {

    private let unitsType: UnitsType = .metrics // TODO: store and resolve from some worker

    func currentWeather(for cityModelId: CityModelId) -> AnyPublisher<CurrentWeatherResult, Never> {
        let conditions = CurrentConditions(weatherIcon: 2,
                                           weatherText: "Przeważnie słonecznie",
                                           temperature: .init(metric: .init(value: 24.5, unit: "C"),
                                                              imperial: .init(value: 76, unit: "F")))

        return Just(CurrentWeatherResult.success(map(conditions))).eraseToAnyPublisher()
    }

    private func map(_ currentConditions: CurrentConditions) -> CurrentWeatherModel { // TODO: Extract
        .init(iconId: currentConditions.weatherIcon,
              description: currentConditions.weatherText,
              temperature: map(currentConditions.temperature))
    }

    private func map(_ temperature: Temperature) -> TemperatureModel { // TODO: Extract
        switch unitsType {
        case .metrics:
            return map(temperature.metric)
        case .imperial:
            return map(temperature.imperial)
        }
    }

    private func map(_ temperature: TemperatureUnitInfo) -> TemperatureModel { // TODO: Extract
        .init(value: temperature.value, unit: temperature.unit)
    }
}
