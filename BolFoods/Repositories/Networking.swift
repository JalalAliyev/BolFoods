import Foundation
import Alamofire

class Networking {
    
    static let shared: Networking = {
        return Networking()
    }()
    
    let baseURL = "http://kasimadalan.pe.hu/foods/"
    
    public func addToBasket(product: Food, quantity: Int, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let endpoint = "insertFood.php"
        let fullURL = baseURL + endpoint
        let parameters: [String: Any] = [
            "name": product.name,
            "image": product.image,
            "price": product.price,
            "category": product.category,
            "orderAmount": quantity,
            "userName": "jalaliyev"
        ]
        AF.request(fullURL, method: .post, parameters: parameters).response {res in
            print("add basket status>>>\(res.response?.statusCode)")
        }
    }
    
    public func apiCaller(_ url: String,
                          method: HTTPMethod = .get,
                          parameters: Parameters? = nil,
                          completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let fullUrl = self.baseURL + url
        AF.request(fullUrl,
                   method: method,
                   parameters: parameters)
        .responseJSON(completionHandler: { (response) in
            completion(response.data, response.response, response.error)
        })
    }
}
