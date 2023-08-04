import Foundation

typealias CityKey = String

struct City: Codable {
    let name: String
    let key: String

    enum CodingKeys: String, CodingKey {
        case name = "LocalizedName"
        case key = "Key"
    }
}
