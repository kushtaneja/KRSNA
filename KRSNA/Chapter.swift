//
//  Chapter.swift
//  KRSNA
//
//  Created by Kush Taneja on 17/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import Foundation

class chapter {
    
    var name: String?
    var title: String?
    
    var numberOfVerses : Int?
    var from: Int?
    var to: Int?
    
    var isCompleted: Bool?
    
    init(chapterName: String?,chapterTitle: String?,chapterVerses: Int?, versesFrom: Int?, versesTo: Int?) {
        
        name = chapterName
        title = chapterTitle
        numberOfVerses = chapterVerses
        from = versesFrom
        to = versesTo
        
    }
    
    
    init() {
    }
    
    
    
    

}
