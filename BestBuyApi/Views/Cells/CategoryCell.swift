//
//  CategoryCell.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var categoryImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCategorieCell() {
        self.categoryLabel.text = "Super Hero Movies"
        self.categoryImageView.image = UIImage(named: "super-hero")
    }
}
