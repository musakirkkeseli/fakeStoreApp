//
//  ProductDetailViewController.swift
//  FakeStore
//
//  Created by Musa KIRKKESELİ on 9.02.2023.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var productDetailImageUrlString : String = ""
    var productDetailAppbarTitle : String = ""
    var productId=0
    private var viewModel : ProductDetailViewModel!
    
    @IBOutlet weak var productDetailImage: UIImageView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var productDetailAppbar: UINavigationItem!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDetailImage.imageFromServerURL(urlString:  productDetailImageUrlString, PlaceHolderImage: UIImage.init(named: "kiyafet.jpeg")!)
        productDetailAppbar.title = productDetailAppbarTitle
        // Do any additional setup after loading the view.
        fetchProduct()
    }
    
    func fetchProduct() {
        
        ProductDetailService().fetchProduct(productId:productId) { (product) in
            if let product = product {
                self.viewModel = ProductDetailViewModel(product: product)
                DispatchQueue.main.async {
                    let vMProduct : Product = self.viewModel.product
                    self.desc.text = "Açıklama: \(vMProduct.description ?? "")"
                    self.categoryName.text = "Kategori: \(vMProduct.category?.rawValue.description ?? "")"
                    let price : String = String(format: "%f", product.price!)
                    self.productPrice.text = "Fiyat: \(price)"
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
