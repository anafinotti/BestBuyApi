//
//  DepartmentCell.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import SDWebImage

class DepartmentCell: UITableViewCell {

    @IBOutlet var departmentImageView: UIImageView!
    @IBOutlet var departmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupDepartmentCell(product: Product) {

        self.departmentLabel.text = product.name
        
        self.departmentImageView.sd_setImage(with: NSURL(string: product.image!) as URL!, placeholderImage: UIImage(), options: SDWebImageOptions.refreshCached) {
            (image, error, cache, url) in
            self.departmentImageView.image = image
        }
    }
}
