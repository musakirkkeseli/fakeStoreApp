//
//  ProductsViewModel.swift
//  FakeStore
//
//  Created by Musa KIRKKESELİ on 9.02.2023.
//

import Foundation

protocol IProductsViewModel {
    func fetchItems()
    func changeLoading()

    var productsCharacters: [Product] { get set }
    var productsService: IProductsService { get }

    var productsOutput: ProductsOutPut? { get }

    func setDelegate(output: ProductsOutPut)
    
    func numberOfRowsInSection()-> Int
    
    func productsAtIndexPath(_ index: Int)->Product
}


struct ProductsViewModel {
    let productList : [Product]
    
//    var productsOutput: ProductsOutPut?
//
//    func setDelegate(output: ProductsOutPut) {
//        productsOutput = output
//    }
//
//
//    var productsCharacters: [Product] = []
//    private var isLoading = false
//    let productsService: IProductsService
//
//
//    init() {
//        productsService = ProductsService()
//    }
//
//    func fetchItems() {
//        changeLoading()
//        productsService.fetchAllDatas { [weak self] (response) in
//            self?.changeLoading()
//            self?.productsCharacters = response ?? []
//            print(self?.productsCharacters)
//            self?.productsOutput?.saveDatas(values: self?.productsCharacters ?? [])
//        }
//
//    }
//
//    func changeLoading() {
//        isLoading = !isLoading
//        productsOutput?.changeLoading(isLoad: isLoading)
//    }
    
    func numberOfRowsInSection() -> Int {
        return self.productList.count
    }
    
    func productsAtIndexPath(_ index: Int) -> Product {
        let product = self.productList[index]
        return product
    }
}
