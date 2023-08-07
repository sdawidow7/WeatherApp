import Foundation
import Combine

protocol SelectCityViewModel {
    func bind(input: SelectCityViewModelInput) -> SelectCityViewModelOutput
}

final class SelectCityViewModelImpl: SelectCityViewModel {

    private var router: SelectCityRouter
    private let useCase: SelectCityUseCase
    private var cancellables: [AnyCancellable] = []

    init(useCase: SelectCityUseCase, router: SelectCityRouter) {
        self.useCase = useCase
        self.router = router
    }

    func bind(input: SelectCityViewModelInput) -> SelectCityViewModelOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        input.selectionPublisher
            .sink(receiveValue: { [unowned self] cityId in self.router.showCityDetails(for: cityId) })
            .store(in: &cancellables)

        let searchInput = input.searchPublisher
            .debounce(for: .milliseconds(Constant.searchDebounceMiliseconds), scheduler: RunLoop.main)
            .removeDuplicates()

        let initialState: SelectCityViewModelOutput = Just<SelectCityState>(.initial).eraseToAnyPublisher()
        let emptySearchString: SelectCityViewModelOutput = searchInput
            .filter { $0.isEmpty }
            .map { _ in .initial }
            .eraseToAnyPublisher()
        let initial: SelectCityViewModelOutput = Publishers.Merge(initialState, emptySearchString)
            .eraseToAnyPublisher()

        let cities = searchInput
            .filter { !$0.isEmpty }
            .map { [unowned self] query in self.useCase.searchCities(with: query) }
            .switchToLatest()
            .map { result -> SelectCityState in
                switch result {
                case .success([]): return .noResults
                case .success(let cities): return .success(cities)
                case .failure(let error): return .failure(.unknown(error))
                }
            }
            .eraseToAnyPublisher()
        return Publishers.Merge(initial, cities)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    private enum Constant {
        static let searchDebounceMiliseconds: Int = 300
    }
}

struct SelectCityViewModelInput {
    let searchPublisher: AnyPublisher<String, Never>
    let selectionPublisher: AnyPublisher<CityModel, Never>
}

typealias SelectCityViewModelOutput = AnyPublisher<SelectCityState, Never>

enum SelectCityState: Equatable {
    case initial
    case noResults
    case success([CityModel])
    case failure(SelectCityError)
}


enum SelectCityError: Error, Equatable {
    static func == (lhs: SelectCityError, rhs: SelectCityError) -> Bool {
        switch lhs {
        case .unknown:
            switch rhs {
            case .unknown:
                return true
            }
        }
    }
    case unknown(Error)
}
