//
//  ProductsViewController.swift
//  FakeStore
//
//  Created by Musa KIRKKESELİ on 9.02.2023.
//

import UIKit

protocol ProductsOutPut {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Product])
}

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel : ProductsViewModel!
    var selectedProductImageUrlString: String = ""
    var selectedProductTitle: String = ""
    var _productId=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        veriAl()
    }
    
    func veriAl() {
        ProductsService().fetchAllDatas() { (products) in
            if let products = products {
                self.viewModel = ProductsViewModel(productList: products)
                print("merhaba")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel == nil ? 0:  self.viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductTableViewCell
        let product = self.viewModel.productsAtIndexPath(indexPath.row)
        cell.productName.text = product.title
        let price : String = String(format: "%f", product.price!)
        cell.productPrice.text = "Fiyat: \(price)"
        let imageUrlString: String = product.image ?? ""
        cell.imageView?.imageFromServerURL(urlString:  imageUrlString, PlaceHolderImage: UIImage.init(named: "kiyafet.jpeg")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.viewModel.productsAtIndexPath(indexPath.row)
        selectedProductImageUrlString = product.image ?? ""
        selectedProductTitle = product.title ?? ""
        _productId = product.id ?? 0
        performSegue(withIdentifier: "toProductsDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductsDetailVC" {
            let destinationVC = segue.destination as! ProductDetailViewController
            destinationVC.productDetailImageUrlString = selectedProductImageUrlString
            destinationVC.productDetailAppbarTitle = selectedProductTitle
            destinationVC.productId = _productId
        }
    }

}

extension UIImageView{
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {

           if self.image == nil{
                 self.image = PlaceHolderImage
           }

           URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

               if error != nil {
                   print(error ?? "No Error")
                   return
               }
               DispatchQueue.main.async(execute: { () -> Void in
                   let image = UIImage(data: data!)
                   self.image = image
               })

           }).resume()
       }
}






