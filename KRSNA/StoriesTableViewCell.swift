//
//  StoriesTableViewCell.swift
//  KRSNA
//
//  Created by Kush Taneja on 06/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postThumbnailView: UIImageView!

    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    var postTitle: String?
    var postDescription: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        postTitleLabel.text = postTitle
        postDescriptionLabel.text = postDescription
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
