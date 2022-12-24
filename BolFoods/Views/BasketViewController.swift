import UIKit

class BasketViewController: UIViewController {
    let basketViewModel = BasketViewModel()
    
    var basketFoods: [CartModel] = [
        .init(cartId: 1000, name: "Julyen", image: "grilledchicken.png", price: 12, category: "Meals", orderAmount: 2, userName: "jalaliyev"),
        .init(cartId: 1001, name: "Julyen", image: "grilledchicken.png", price: 12, category: "Meals", orderAmount: 2, userName: "jalaliyev"),
        .init(cartId: 1002, name: "Julyen", image: "grilledchicken.png", price: 12, category: "Meals", orderAmount: 2, userName: "jalaliyev"),
        .init(cartId: 1003, name: "Julyen", image: "grilledchicken.png", price: 12, category: "Meals", orderAmount: 2, userName: "jalaliyev")
    ]

    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var basketOutlet: UIButton!
    var totalAmount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basketTableView.delegate = self
        basketTableView.dataSource = self
        
        basketTableView.showsVerticalScrollIndicator = false
        basketTableView.register(UINib(nibName: BasketTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BasketTableViewCell.identifier)
        
        _ = basketViewModel.basketProducts.subscribe( onNext: { basketFoods in
             self.basketFoods = basketFoods
            basketFoods.forEach { food in
                self.totalAmount += food.price * food.orderAmount
            }
             DispatchQueue.main.async {
                 self.basketOutlet.setTitle("Order now: \(self.totalAmount)$", for: .normal)
                 self.basketTableView.reloadData()
             }
         })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        basketViewModel.getBasketProducts()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsModallySegue" {
            if let food = sender as? Food {
                print("food name>>>\(food.name)")
                let productDetailsScreen = segue.destination as! ProductDetailsViewController
                productDetailsScreen.productDetail = food
            }
        }
    }

}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("basketFoods.count>>>\(basketFoods.count)")
        return basketFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basketProduct = basketFoods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as! BasketTableViewCell
        cell.configure(basketProduct: basketProduct)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = basketFoods[indexPath.row]
        let food = Food(id: product.cartId, name: product.name, image: product.image, price: product.price, category: product.category)
        performSegue(withIdentifier: "detailsModallySegue", sender: food)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, bool in
            let product = self.basketFoods[indexPath.row]
            self.basketViewModel.deleteProduct(cartId: product.cartId)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
