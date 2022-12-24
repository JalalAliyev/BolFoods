import UIKit
import Kingfisher

class BasketTableViewCell: UITableViewCell {
    static let identifier = "BasketTableViewCell"
    let basketViewModel = BasketViewModel()

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var product: Food?
    var orderAmount: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        print("BasketTableViewCell called!")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(basketProduct: CartModel) {
        productImage.kf.setImage(with: basketProduct.image.imageUrl)
        productName.text = basketProduct.name
        quantity.text = "Quantity:\(basketProduct.orderAmount)"
        productPrice.text = "\(basketProduct.price)$"
        totalPrice.text = "Total: \(basketProduct.price * basketProduct.orderAmount)$"
        product = Food(id: basketProduct.cartId, name: basketProduct.name, image: basketProduct.image, price: basketProduct.price, category: basketProduct.category)
        orderAmount = basketProduct.orderAmount
    }
    
    @IBAction func incQuanity(_ sender: Any) {
        if let food = product, orderAmount != nil {
            orderAmount! += 1
            print("orderAmount>>>\(orderAmount)")
            basketViewModel.changeBasketProduct(food: food, quantity: orderAmount!)
        }
    }
    @IBAction func decQuantity(_ sender: Any) {
        if let food = product, orderAmount != nil {
            orderAmount! -= 1
            print("orderAmount>>>\(orderAmount)")
            basketViewModel.changeBasketProduct(food: food, quantity: orderAmount!)
        }
    }
}
