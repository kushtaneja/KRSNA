//
//  ChapterListTableViewCell.swift
//  KRSNA
//
//  Created by Kush Taneja on 17/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit

class ChapterListTableViewCell: UITableViewCell {

    @IBOutlet weak var chapterNameLabel: UILabel!
    
    @IBOutlet weak var chapterTitleLabel: UILabel!
    
    @IBOutlet weak var numberOfVersesLabel: UILabel!
    
    var numberOfVerses: Int?
    var title: String?
    var name: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chapterNameLabel.text = name
        chapterTitleLabel.text = title
        numberOfVersesLabel.text = "\(numberOfVerses)" + " " + "verses"
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
