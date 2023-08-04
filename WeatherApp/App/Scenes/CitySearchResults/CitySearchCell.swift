import UIKit

final class CitySearchCell: UITableViewCell {}

extension UITableViewCell {
    static func reuseIdentifier() -> String {
        String(describing: self)
    }
}

// TODO: Extract
public extension UITableView {
    func dequeue<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier(), for: indexPath) as? T else {
            fatalError("Cannot dequeue cell in type: \(cellClass) at indexPath: \(indexPath)")
        }
        return cell
    }
}

public extension UITableViewCell {
    static func registerClass(tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier())
    }
}
