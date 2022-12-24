import Foundation
import RxSwift
import Alamofire

class BasketViewModel {
    var basketProducts = BehaviorSubject<[CartModel]>(value: [])
    
    let networking = Networking()
    
    // Get all card foods -> http://kasimadalan.pe.hu/foods/getFoodsCart.php (method: POST, required field: username)
    
    func getBasketProducts() {
        AF.upload(multipartFormData: { multiFormData in
            multiFormData.append(Data("jalaliyev".utf8), withName: "userName")
        }, to: "http://kasimadalan.pe.hu/foods/getFoodsCart.php").responseDecodable(of: BasketModel.self) {response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(BasketModel.self, from: data)
                    var tempBasketFoods = [CartModel]()
                    result.foods_cart.forEach { food in
                        if let basketFood = food as? CartModel {
                            tempBasketFoods.append(food!)
                        }
                    }
                    self.basketProducts.onNext(tempBasketFoods)
                }catch {
                    self.basketProducts.onNext([])
                    print(error)
                }
            }
        }
    }
    
    func deleteProduct(cartId: Int) {
        let endpoint = "deleteFood.php"
        let params: [String: Any] = [
            "cartId": cartId,
            "userName": "jalaliyev"
        ]
        networking.apiCaller(endpoint,method: .post, parameters: params) { data, _, _ in
            self.getBasketProducts()
        }
    }
    
    func changeBasketProduct(food: Food, quantity: Int) {
        let endpoint = "deleteFood.php"
        let params: [String: Any] = [
            "cartId": food.id,
            "userName": "jalaliyev"
        ]
        networking.apiCaller(endpoint,method: .post, parameters: params) { data, _, _ in
            self.networking.addToBasket(product: food, quantity: quantity) { data, _, _ in
                self.getBasketProducts()
            }
        }
        self.getBasketProducts()
    }
    
}
