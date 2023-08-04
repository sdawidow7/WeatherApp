import Combine

typealias CitySearchResult = Result<[CityModel], Error>

protocol SelectCityUseCase {
    func searchCities(with name: String) -> AnyPublisher<CitySearchResult, Never>
}

final class SelectCityUseCaseImpl: SelectCityUseCase {
    func searchCities(with name: String) -> AnyPublisher<CitySearchResult, Never> {
        return Just(.success([.init(cityId: "3123", cityName: "Kraków")])).eraseToAnyPublisher() // TODO: Implement
    }
}
