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
    var verse: String?
    var wordForWord: String?
    var purport: String?
    
    var audioUrl: URL?
    var imageUrl: URL?
    
    var number : Int?
    var from: Int?
    var to: Int?
    var key: Int?
    
    var isCompleted: Bool?
    
    init(verseNumber: Int? ,verseTranslation: String?,verseChapter: String?, verseContent: String?, atKey: Int?) {
        
        translation = verseTranslation
        chapter = verseChapter
        number = verseNumber
        verse = verseContent
        key = atKey
    }
    
    init(verseNumber: Int? ,verseAudioUrl: String?,verseContent: String?,verseWordForWord: String?,verseTranslation: String?,versePurport:String? ,verseChapter: String?,verseImageUrl: String?){
        
        purport = (versePurport != nil || versePurport != "") ? versePurport! : nil
        wordForWord = (verseWordForWord != nil || verseWordForWord != "") ? verseWordForWord! : nil
        translation = (verseTranslation != nil || verseTranslation != "") ? verseTranslation! : nil
        chapter = (verseChapter != nil || verseChapter != "") ? verseChapter! : nil
        number = (verseNumber != nil) ? verseNumber! : nil
        verse = (verseContent != nil || verseContent != "") ? verseContent! : nil 
        audioUrl = (verseAudioUrl != nil || verseAudioUrl != "") ? URL(string: verseAudioUrl!)! : nil
        imageUrl = (verseImageUrl != nil || verseImageUrl != "") ? URL(string: verseImageUrl!)! : nil
    
    }
    
    
    init() {
    }
    
    
    
    
    
}
