//
//  Verse.swift
//  KRSNA
//
//  Created by Kush Taneja on 18/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import Foundation


class verse {
    
    var translation: String?
    var chapter: String?
    
    var number : Int?
    var from: Int?
    var to: Int?
    
    var isCompleted: Bool?
    
    init(verseNumber: Int? ,verseTranslation: String?,verseChapter: String?) {
        
        translation = verseTranslation
        chapter = verseChapter
        number = verseNumber
    }
    
    
    init() {
    }
    
    
    
    
    
}
