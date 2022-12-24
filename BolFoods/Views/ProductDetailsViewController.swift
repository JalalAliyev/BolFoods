import UIKit
import Kingfisher

class ProductDetailsViewController: UIViewController {
    let prodDetailsVM = ProductDetailsViewModel()
    
    var initialQuantity = 1
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    var productDetail: Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let productDetail = productDetail {
            productName.text = productDetail.name
            productImage.kf.setImage(with: productDetail.image.imageUrl)
            productPrice.text = "\(productDetail.price) $"
            quantity.text = String(initialQuantity)
            totalPrice.text = "Total Price: \(productDetail.price * initialQuantity)$"
        }
    }
    
    @IBAction func incQuantityTapped(_ sender: Any) {
        initialQuantity += 1
        quantity.text = String(initialQuantity)
        if let price = productDetail?.price {
            totalPrice.text = "Total Price: \(initialQuantity * price)$"
        }
    }
    
    @IBAction func decQuantityTapped(_ sender: Any) {
        if initialQuantity != 0, let price = productDetail?.price {
            initialQuantity -= 1
            quantity.text = String(initialQuantity)
            totalPrice.text = "Total Price: \(initialQuantity * price)$"
        }
    }
    
    @IBAction func addToBasketTapped(_ sender: Any) {
        if initialQuantity != 0, let product = productDetail {
            prodDetailsVM.insertToBasket(product: product, quantity: initialQuantity)
        }
    }
    
}
