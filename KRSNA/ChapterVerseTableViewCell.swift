//
//  ChapterVerseTableViewCell.swift
//  KRSNA
//
//  Created by Kush Taneja on 18/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit

class ChapterVerseTableViewCell: UITableViewCell {
    @IBOutlet weak var verseHeadingLabel: UILabel!

    @IBOutlet weak var verseTranlsationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
