import UIKit
import Combine

final class SelectCityViewController: UIViewController {

    private let viewModel: SelectCityViewModel
    private lazy var searchController = UISearchController(searchResultsController: citySearchViewController)
    private let citySearchViewController: CitySearchResultsViewController

    private let searchSubject: PassthroughSubject<String, Never>
    private var cancellables: [AnyCancellable] = []

    init(viewModel: SelectCityViewModel,
         citySearchViewController: CitySearchResultsViewController,
         searchSubject: PassthroughSubject<String, Never>) {
        self.viewModel = viewModel
        self.citySearchViewController = citySearchViewController
        self.searchSubject = searchSubject
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        bind(to: viewModel)
    }

    // MARK: - Private

    private func setUpViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Szukaj miasta" // TODO: Localize
        searchController.searchBar.searchTextField.delegate = self

        navigationItem.searchController = searchController
        navigationItem.title = "Pogoda" // TODO: Localize
    }

    private func bind(to viewModel: SelectCityViewModel) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        let input = SelectCityViewModelInput(searchPublisher: searchSubject.eraseToAnyPublisher(),
                                             selectionPublisher: citySearchViewController.selectionPublisher)

        let output = viewModel.bind(input: input)

        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }

    private func render(_ state: SelectCityState) {
        switch state {
        case let .success(cities):
            DispatchQueue.main.async { [weak self] in
                self?.citySearchViewController.update(with: cities)
            }
        case .failure, .initial, .noResults : break // TODO: handle other states
        }
    }
}

extension SelectCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchSubject.send(searchController.searchBar.text ?? "")
    }
}

extension SelectCityViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let pattern = "[A-Za-zżźćńółęąśŻŹĆĄŚĘŁÓŃ ]" // TODO: Extract validation
        guard string != "" else { return true }
        guard let result = string.range(of: pattern, options: .regularExpression) else { return false }
        return true
    }
}

extension SelectCityViewController {
    convenience init(viewModel: SelectCityViewModel, citySearchViewController: CitySearchResultsViewController) {
        self.init(viewModel: viewModel,
                  citySearchViewController: citySearchViewController,
                  searchSubject: PassthroughSubject<String, Never>())
    }
}
