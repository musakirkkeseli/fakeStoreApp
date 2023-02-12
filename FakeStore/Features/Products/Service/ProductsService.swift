//
//  ProductsService.swift
//  FakeStore
//
//  Created by Musa KIRKKESELİ on 9.02.2023.
//

import Foundation
import Alamofire

enum ProductsServiceEndPoint: String {
    case BASE_URL = "https://fakestoreapi.com/"
    case PATH = "products"
    
    static func characterPath()-> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IProductsService{
    func fetchAllDatas(response: @escaping ([Product]?)->Void)
}

struct ProductsService: IProductsService {

    func fetchAllDatas(response: @escaping ([Product]?) -> Void) {
        AF.request(ProductsServiceEndPoint.characterPath()).responseDecodable(of: [Product].self) { (model) in
         
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data)
        }
    }

}
