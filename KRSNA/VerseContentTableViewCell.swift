//
//  VerseContentTableViewCell.swift
//  KRSNA
//
//  Created by Kush Taneja on 24/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit

class VerseContentTableViewCell: UITableViewCell {

    @IBOutlet weak var verseCellTitleLabel: UILabel!
    
    @IBOutlet weak var verseCellContentLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
