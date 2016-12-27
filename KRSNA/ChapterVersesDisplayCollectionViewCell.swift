//
//  ChapterVersesDisplayCollectionViewCell.swift
//  KRSNA
//
//  Created by Kush Taneja on 24/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit


class ChapterVersesDisplayCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var verseOverviewTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!

    var contentRect = CGRect.zero
    var currentVerse: verse?
    var nextVerse: verse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        debugPrint("AWAKKKEEE")
//        verseOverviewTextView.autoresizingMask = UIViewAutoresizing.flexibleHeight
//        headerView.autoresizingMask = UIViewAutoresizing.flexibleHeight
//    
           }

}
