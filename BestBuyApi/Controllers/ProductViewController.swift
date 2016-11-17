//
//  ProductViewController.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    private var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        self.getProducts()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    func getProducts() {
        _ = BestBuyProvider.request(.products("")) { result in
            switch result {
            case let .success(response):
                do {
                    if let products = try Mapper<BestBuyProducts>().map(JSONObject: response.mapJSON()){
                        self.products = products.products!
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
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        cell.setupProductCell(product: self.products[indexPath.row])
        return cell
    }
}