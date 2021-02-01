
//  A2_FA_IOS_TANVINDER_C0783504
//  Created by Tanvinder on 2/2/21.
//

import UIKit
import CoreData

class LandingProductScreen: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrp = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingProductsFromCoreData()
        addProductsInCoreData()
        tableView.reloadData()
        self.title = "Products"
        
    }
    func addProductsInCoreData(){
        if arrp.count == 0{
            let provider = Provider(context: context)
            provider.provider = "SUZUKI"
            let provider2 = Provider(context: context)
            provider2.provider = "SHUBURU"
            for i in 0...9{
                
                if i < 5 {
                    let product = Product(context: context)
                    product.product_desc = "BEST"
                    product.product_id = "\(i+100)"
                    product.product_name = "H \(i+1)"
                    product.product_price = "\(i+1)0000"
                   product.providerToProduct = provider
                }
                else{
                    try! context.save()
                    let product = Product(context: context)
                    product.product_desc = "BEST"
                    product.product_name = "A \(i+1)"
                    product.product_id = "\(i+100)"
                    product.product_price = "\(i+1)0000"
                   product.providerToProduct = provider2
                }
                

            }
         
            try! context.save()
            gettingProductsFromCoreData()
        }
    }
    
    func gettingProductsFromCoreData(){
        arrp.removeAll()
        arrp = try! context.fetch(Product.fetchRequest())
        tableView.reloadData()
    }
    
    // MARK: - Table View Data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrp.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text =
                arrp[indexPath.row].product_name
            cell.detailTextLabel?.text = arrp[indexPath.row].providerToProduct?.provider
        return cell
    }
    

}
extension LandingProductScreen : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            var predicate: NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "product_name contains[c] '\(searchText)' || product_desc contains[c] '\(searchText)'")
            let fetchRequest : NSFetchRequest<Product> = Product.fetchRequest()
            fetchRequest.predicate = predicate
            do {
                arrp = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error)")
            }
        }
        else{
            gettingProductsFromCoreData()
            
        }
        tableView.reloadData()
    }
}
