//
//  MusicArtistTableViewCell.swift
//  KRSNA
//
//  Created by Kush Taneja on 06/02/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import UIKit

class MusicArtistTableViewCell: UITableViewCell {

    @IBOutlet weak var displayImageView: UIImageView!
    
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
