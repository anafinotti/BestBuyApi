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

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupProductCell(product: Product) {

        self.productNameLabel.text = product.name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        // formatter.locale = NSLocale.currentLocale() // This is the default
        
        self.productPriceLabel.text =  formatter.string(for: product.salePrice)
//"\(product.salePrice)"
        
        self.productImageView.sd_setImage(with: NSURL(string: product.image!) as URL!, placeholderImage: UIImage(), options: SDWebImageOptions.refreshCached) {
            (image, error, cache, url) in
            self.productImageView.image = image
        }
    }
}
