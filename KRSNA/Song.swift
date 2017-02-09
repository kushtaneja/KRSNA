//
//   self.swift
//  KRSNA
//
//  Created by Kush Taneja on 06/02/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import Foundation

class Song{
    
      var album:String?
      var artist:String?
   //   var category:String?
      var duration:Int?
      var imageLink:String?
      var likes:Int?
      var shares:Int?
      var source:String?
      var title:String?
      var views:Int?
   //   var genre:[String]?
      var types:[MusicType]?
    
    
    init(songAlbum:String? = nil,songArtist:String? = nil,songDuration:Int? = nil,songImageLink:String? = nil,songLikes:Int? = nil,songShares:Int? = nil,songSource:String? = nil,songTitle:String? = nil,songViews:Int? = nil,songTypes:[MusicType]? = nil) {
        
         self.album = songAlbum
         self.artist = songArtist
         self.duration = songDuration
         self.imageLink = songImageLink
         self.likes = songLikes
         self.title = songTitle
         self.source = songSource
         self.views = songViews
         self.types = songTypes

    }

}

class SongClassifier{
    
    var name:String?
      var imageUrl:String?
      var type:MusicType?
    
    init(classifierType:MusicType? = nil,classifierName:String? = nil,classifierImageUrl:String? = nil){
        
         self.imageUrl = classifierImageUrl
         self.type = classifierType
        self.name = classifierName
    }




}

public enum MusicType{
    case category
    case genre
    case artist
 
}


