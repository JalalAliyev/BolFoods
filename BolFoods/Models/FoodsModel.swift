import Foundation

enum FoodEnum {
    case Meals
    case Desserts
    case Drinks
}

struct FoodsModel: Codable {
    let foods: [Food]
}

struct Food: Codable {
    let id: Int
    let name: String
    let image: String
    let price: Int
    let category: String
}
