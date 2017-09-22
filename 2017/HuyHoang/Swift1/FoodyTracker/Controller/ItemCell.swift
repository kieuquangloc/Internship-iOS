//
//  ItemCell.swift
//  FoodyTracker
//
//  Created by HHumorous on 9/18/17.
//  Copyright © 2017 HHumorous. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var titleFood: UILabel!
    @IBOutlet weak var ratingStar: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
