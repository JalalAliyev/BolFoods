import UIKit

class HomeViewController: UIViewController {
    let homeViewModel = HomeViewModel()
    
    @IBOutlet weak var mainDishesCollectionView: UICollectionView!
    @IBOutlet weak var desertsCollectionView: UICollectionView!
    @IBOutlet weak var drinksCollectionView: UICollectionView!
    
    
    var mainDishes = [Food]()
    var desserts = [Food]()
    var drinks = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = homeViewModel.mainDishes.subscribe(onNext: { mainDishes in
            self.mainDishes = mainDishes
            DispatchQueue.main.async {
                self.mainDishesCollectionView.reloadData()
            }
        })
        _ = homeViewModel.desserts.subscribe(onNext: { desserts in
            self.desserts = desserts
            DispatchQueue.main.async {
                self.desertsCollectionView.reloadData()
            }
        })
        _ = homeViewModel.drinks.subscribe(onNext: { drinks in
            self.drinks = drinks
            DispatchQueue.main.async {
                self.drinksCollectionView.reloadData()
            }
        })
        
        
        registerCells()
        
        mainDishesCollectionView.dataSource = self
        mainDishesCollectionView.delegate = self
        desertsCollectionView.dataSource = self
        desertsCollectionView.delegate = self
        drinksCollectionView.dataSource = self
        drinksCollectionView.delegate = self
    }
    
    private func registerCells() {
        mainDishesCollectionView.register(UINib(nibName: MainDishCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainDishCollectionViewCell.identifier)
        desertsCollectionView.register(UINib(nibName: MainDishCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainDishCollectionViewCell.identifier)
        drinksCollectionView.register(UINib(nibName: MainDishCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainDishCollectionViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetailSegue" {
            if let product = sender as? Food {
                let productDetailsScreen = segue.destination as! ProductDetailsViewController
                productDetailsScreen.productDetail = product
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainDishesCollectionView:
            return mainDishes.count
        case desertsCollectionView:
            return desserts.count
        case drinksCollectionView:
            return drinks.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var data: Food?
        
        switch collectionView {
        case mainDishesCollectionView:
            data = mainDishes[indexPath.row]
        case desertsCollectionView:
            data = desserts[indexPath.row]
        case drinksCollectionView:
            data = drinks[indexPath.row]
        default:
            data = nil
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainDishCollectionViewCell.identifier, for: indexPath) as! MainDishCollectionViewCell
        if let product = data {
            cell.configure(productDetails: product)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var data: Food?
        
        switch collectionView {
        case mainDishesCollectionView:
            data = mainDishes[indexPath.row]
        case desertsCollectionView:
            data = desserts[indexPath.row]
        case drinksCollectionView:
            data = drinks[indexPath.row]
        default:
            data = nil
        }
        
        performSegue(withIdentifier: "productDetailSegue", sender: data)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

