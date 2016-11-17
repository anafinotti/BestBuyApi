//
//  DepartmentCell.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit

class DepartmentCell: UITableViewCell {

    @IBOutlet var departmentImageView: UIImageView!
    @IBOutlet var departmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupDepartmentCell() {
        
    }
}
