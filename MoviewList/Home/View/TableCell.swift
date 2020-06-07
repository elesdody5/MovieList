//
//  TableCell.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 3/29/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var relaseYearLabe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
