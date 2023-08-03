import UIKit

final class SelectCityViewController: UIViewController {

    private let viewModel: SelectCityViewModel
    private lazy var searchController = UISearchController(searchResultsController: nil)

    init(viewModel: SelectCityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

    // MARK: - Private

    private func setUpViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Szukaj miasta" // TODO: Localize

        navigationItem.searchController = searchController
        navigationItem.title = "Pogoda" // TODO: Localize
    }
}

extension SelectCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("Update") // TODO: Implement
    }
}
