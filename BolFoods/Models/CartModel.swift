import Foundation

struct BasketModel: Decodable {
    let foods_cart: [CartModel?]
}

struct CartModel: Decodable {
    let cartId: Int
    let name: String
    let image: String
    let price: Int
    let category: String
    let orderAmount: Int
    let userName: String
}

struct AddBasketModel: Encodable {
    let name: String
    let image: String
    let price: Int
    let category: String
    let orderAmount: Int
    let userName: String
}
