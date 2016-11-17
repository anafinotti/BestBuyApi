//
//  DepartmentViewController.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import ObjectMapper

class DepartmentViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    var products = [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getProducts("")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    func getProducts(_ username: String) {
        _ = BestBuyProvider.request(.products(username)) { result in
            switch result {
            case let .success(response):
                do {
                    if let products = try Mapper<BestBuyProducts>().map(JSONObject: response.mapJSON()){
                        print(products)
                    } else {
                        self.showAlert("Parse Error", message: "Unable to parse object from BestBuy API")
                    }
                } catch {
                    self.showAlert("BestBuy api Error", message: "Unable to get response from api")
                }
                self.tableView.reloadData()
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                self.showAlert("GitHub Fetch", message: error.description)
            }
        }
    }

}
