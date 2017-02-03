//
//  ItemTableViewCell.swift
//  MoneyTracker
//
//  Created by Dean Gaffney on 25/11/2016.
//  Copyright © 2016 Dean Gaffney. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var itemCostLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
