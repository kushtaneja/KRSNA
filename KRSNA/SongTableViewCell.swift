//
//  SongTableViewCell.swift
//  KRSNA
//
//  Created by Kush Taneja on 28/02/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
