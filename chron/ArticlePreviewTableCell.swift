//
//  ArticlePreviewTableCell.swift
//  chron
//
//  Created by Michael Lai on 12/29/14.
//  Copyright (c) 2014 Duke Chronicle. All rights reserved.
//

import UIKit

class ArticlePreviewTableCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var infoLabel: UILabel?
    @IBOutlet weak var thumbnail: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
