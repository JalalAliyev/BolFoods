import Foundation
import RxSwift
//https://github.com/onevcat/Kingfisher -- KingFisher for image
//https://github.com/ReactiveX/RxSwift --RxSwift for updating UI


// Get all foods -> http://kasimadalan.pe.hu/foods/getAllFoods.php
// Get all card foods -> http://kasimadalan.pe.hu/foods/getFoodsCart.php (method: POST, required field: username)
// Insert food to card -> http://kasimadalan.pe.hu/foods/insertFood.php (required field: ...food, username, orderAmound)
// Delete food from card -> http://kasimadalan.pe.hu/foods/deleteFood.php (required field: username, cardId)
// Api for Kingfisher -> http://kasimadalan.pe.hu/foods/images/productImageName.png

class HomeViewModel {
    var mainDishes = BehaviorSubject<[Food]>(value: [Food]())
    var desserts = BehaviorSubject<[Food]>(value: [Food]())
    var drinks = BehaviorSubject<[Food]>(value: [Food]())
    let networking = Networking()
    
    init() {
        getAllFoods()
    }
    
    func getAllFoods() {
        networking.apiCaller("getAllFoods.php") { data, _, _ in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(FoodsModel.self, from: data)
                    var tempMainDishes = [Food]()
                    var tempDesserts = [Food]()
                    var tempDrinks = [Food]()
                    result.foods.forEach { food in
                        switch food.category {
                        case "Meals":
                            tempMainDishes.append(food)
                        case "Desserts":
                            tempDesserts.append(food)
                        default:
                            tempDrinks.append(food)
                        }
                    }
                    self.mainDishes.onNext(tempMainDishes)
                    self.desserts.onNext(tempDesserts)
                    self.drinks.onNext(tempDrinks)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func addToBasket(product: Food, quantity: Int) {
        networking.addToBasket(product: product, quantity: quantity) { _, _, _ in
            print("success")
        }
    }
}
