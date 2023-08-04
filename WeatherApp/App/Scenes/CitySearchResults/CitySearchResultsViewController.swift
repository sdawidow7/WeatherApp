import UIKit
import Combine

protocol CitySearchResultsDisplayLogic: UIViewController {
    func update(with list: [CityModel], animated: Bool)
    var selectionPublisher: AnyPublisher<CityModelId, Never> { get }
}

final class CitySearchResultsViewController: UIViewController, CitySearchResultsDisplayLogic {

    lazy var selectionPublisher = selectionSubject.eraseToAnyPublisher()

    private lazy var tableView = UITableView()
    private lazy var dataSource: CitySearchDiffableDataSource = makeDataSource()

    private let selectionSubject = PassthroughSubject<CityModelId, Never>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
    }

    // MARK: - API

    func update(with list: [CityModel], animated: Bool = true) {
        var snapshot = CitySearchDiffableSnapshot()

        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .main)

        dataSource.apply(snapshot, animatingDifferences: animated)
    }

    // MARK: - Private

    private func setUpSubviews() {
        view.addSubview(tableView)
        tableView.delegate = self
        setUpProperties()
        setUpConstraints()
    }

    private func setUpConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setUpProperties() {
        CitySearchCell.registerClass(tableView: tableView)
    }
}

// MARK - Data source
private extension CitySearchResultsViewController {

    typealias CitySearchDiffableDataSource = UITableViewDiffableDataSource<Section, CityModel>
    typealias CitySearchDiffableSnapshot = NSDiffableDataSourceSnapshot<Section, CityModel>
    enum Section: CaseIterable {
        case main
    }

    func makeDataSource() -> CitySearchDiffableDataSource {

        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, city in
                let cell = tableView.dequeue(cellClass: CitySearchCell.self, for: indexPath)

                cell.textLabel?.text = city.cityName
                return cell
            }
        )
    }
}

// MARK: - Table View delegate

extension CitySearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snaphot = dataSource.snapshot()
        let selectedItem = snaphot.itemIdentifiers[indexPath.row]
        selectionSubject.send(selectedItem.cityId)
    }
}
