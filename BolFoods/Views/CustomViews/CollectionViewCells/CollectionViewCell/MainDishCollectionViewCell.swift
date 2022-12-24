import UIKit
import Kingfisher

class MainDishCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainDishCollectionViewCell"
    let homeViewModel = HomeViewModel()
    var productDetails: Food?
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    
    func configure(productDetails: Food) {
        self.productDetails = productDetails
        self.productName.text = productDetails.name
        self.productImage.kf.setImage(with: productDetails.image.imageUrl)
        self.productPrice.text = "\(productDetails.price)$"
    }
    
    @IBAction func addToBasket(_ sender: Any) {
        if let product = productDetails {
            print("added to basket!")
            homeViewModel.addToBasket(product: product, quantity: 1)
        }
    }
}
