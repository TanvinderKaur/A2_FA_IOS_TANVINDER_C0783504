

//  Created by Tanvinder on 01/02/21.
//

import UIKit
import CoreData

class GetProductsScreen: UITableViewController {
    var selectedProvider : Provider?
    var arrayProducts : [Product] = []
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = selectedProvider{
            let req : NSFetchRequest<Product> =  Product.fetchRequest()
            arrayProducts = try! context.fetch(req)
            arrayProducts = arrayProducts.filter({$0.providerToProduct?.provider == selectedProvider?.provider})
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayProducts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = arrayProducts[indexPath.row].product_name
        cell.detailTextLabel?.text = arrayProducts[indexPath.row].providerToProduct?.provider

        return cell
    }
    


}
