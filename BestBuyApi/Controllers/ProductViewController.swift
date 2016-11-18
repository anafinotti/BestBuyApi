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
    
    private var filteredProducts = [Product]()
    
    let searchController = UISearchController(searchResultsController: nil)

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredProducts = products.filter { product in
            return (product.name?.lowercased().contains(searchText.lowercased()))!
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        self.getProducts()
        
        searchController.searchBar.barStyle = .default
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        
        let ascendingRightBarButton = UIBarButtonItem(image: UIImage(named:"sort-by-ascending"), style: .plain, target: self, action: #selector(ProductViewController.sortByAscendingPrice))
        
        let decrescentRightBarButton = UIBarButtonItem(image: UIImage(named:"sort-by-decrescent"), style: .plain, target: self, action: #selector(ProductViewController.sortByDecrescentPrice))
        

        self.navigationItem.rightBarButtonItems = [decrescentRightBarButton, ascendingRightBarButton]

    }
    
    func sortByAscendingPrice() {
        self.products.sort { ($0.salePrice?.isLessThanOrEqualTo($1.salePrice!))! }
        self.tableView.reloadData()
    }
    func sortByDecrescentPrice() {
        self.products.sort { (!($0.salePrice?.isLessThanOrEqualTo($1.salePrice!))!) }
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
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
                self.showAlert("BestBuy api Error", message: error.description)
            }
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredProducts.count
        }
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        var product: Product?
        
        if searchController.isActive && searchController.searchBar.text != "" {
            product = filteredProducts[indexPath.row]
        } else {
            product = products[indexPath.row]
        }
        
        cell.setupProductCell(product: product!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var product: Product?
        
        if searchController.isActive && searchController.searchBar.text != "" {
            product = filteredProducts[indexPath.row]
        } else {
            product = products[indexPath.row]
        }
        
        let selectedProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectedProductViewController") as! SelectedProductViewController
        
        selectedProductViewController.title = product?.name
        selectedProductViewController.selectedProduct = product
        
        self.navigationController?.pushViewController(selectedProductViewController, animated: true)
        
    }
}

extension ProductViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
