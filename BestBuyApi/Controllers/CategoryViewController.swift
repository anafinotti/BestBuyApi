//
//  CategoryViewController.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import ObjectMapper

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!


    private var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        
//        self.getCategories("")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    fileprivate func showAlert(_ title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(ok)
//        present(alertController, animated: true, completion: nil)
//    }
//    
//    func getCategories(_ id: String) {
//        _ = BestBuyProvider.request(.categories(id)) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    if let categories = try Mapper<Categories>().map(JSONObject: response.mapJSON()){
//                        self.categories = categories.categories!
//                    } else {
//                        self.showAlert("Parse Error", message: "Unable to parse object from BestBuy API")
//                    }
//                } catch {
//                    self.showAlert("BestBuy api Error", message: "Unable to get response from api")
//                }
//                self.tableView.reloadData()
//            case let .failure(error):
//                guard let error = error as? CustomStringConvertible else {
//                    break
//                }
//                self.showAlert("GitHub Fetch", message: error.description)
//            }
//        }
//
//    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //   return self.categories.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.setupCategorieCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        self.navigationController?.pushViewController(productViewController, animated: true)
        
    }
}
