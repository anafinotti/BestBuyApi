//
//  ProductCell.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    
    private var currentProduct: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 0
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor(red:0.40, green:0.20, blue:0.60, alpha:1.0).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.productNameLabel.text = ""
        self.productPriceLabel.text = ""
    }
    
    func setupProductCell(product: Product) {
        self.currentProduct = product
        
        self.productNameLabel.text = product.name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        self.productPriceLabel.text =  formatter.string(for: product.salePrice)
        
        self.productImageView.sd_setImage(with: NSURL(string: product.image!) as URL!, placeholderImage: UIImage(), options: SDWebImageOptions.refreshCached) {
            (image, error, cache, url) in
            self.productImageView.image = image
        }
    }
//    @IBAction func shareButtonTapped(_ sender: Any) {
//        let objectsToShare = [self.currentProduct?.name, self.currentProduct?.image]
//        let activityViewController: UIActivityViewController = UIActivityViewController.init(activityItems: objectsToShare, applicationActivities: nil)
//        
//        let visibleViewController = (UIApplication.shared.keyWindow?.rootViewController as? UINavigationController)?.visibleViewController
//        
//        visibleViewController?.present(activityViewController, animated: true, completion: { 
//        })
//        
//    }
}
