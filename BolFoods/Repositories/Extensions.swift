import Foundation

extension String {
    var imageUrl: URL? {
        return URL(string: "http://kasimadalan.pe.hu/foods/images/\(self)")
    }
}
