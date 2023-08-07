import Combine

typealias CitySearchResult = Result<[CityModel], Error>

protocol SelectCityUseCase {
    func searchCities(with name: String) -> AnyPublisher<CitySearchResult, Never>
}

final class SelectCityUseCaseImpl: SelectCityUseCase {

    private let citySearchRepository: CitySearchRepository

    init(citySearchRepository: CitySearchRepository) {
        self.citySearchRepository = citySearchRepository
    }

    func searchCities(with name: String) -> AnyPublisher<Result<[CityModel], Error>, Never> {
        return Future(asyncFunc: {
            let cities = try await self.citySearchRepository.searchCities(with: name)
            return CitySearchResult.success(cities)
        }).catch({ error in
            return Just(CitySearchResult.failure(error))
        })
        .eraseToAnyPublisher()

    }
}
