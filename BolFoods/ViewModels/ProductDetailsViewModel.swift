import Foundation

class ProductDetailsViewModel {
    let networking = Networking()
    
    func insertToBasket(product: Food, quantity: Int) {
        networking.addToBasket(product: product, quantity: quantity) { _, _, _ in
        }
    }
}
