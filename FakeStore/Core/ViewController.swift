//
//  ViewController.swift
//  FakeStore
//
//  Created by Musa KIRKKESELİ on 9.02.2023.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func navigatorButton(_ sender: Any) {
                performSegue(withIdentifier: "toProductsVC", sender: nil)
    }
    
    
}

