//
//  Video.swift
//  KRSNA
//
//  Created by Kush Taneja on 28/02/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import Foundation

public class Video{
    
    var category: category?
    var description: String?
    var duration: String?
    var key: String?
    var likes: Int = 0
    var shares: Int = 0
    var title: String?
    var url: String?
    var views: Int = 0
    
    init(videoCategory: category? = nil,videoDescription:String? = nil,videoDuration:String? = nil,videoKey:String? = nil,videoLikes:Int? = 0,videoShares:Int? = 0,videoTitle: String? = nil, videoUrl: String? = nil ,videoViews: Int? = 0){
        
        self.category = videoCategory
        self.description = videoDescription
        self.duration = videoDuration
        self.key = videoKey
        self.likes = videoLikes!
        self.shares = videoShares!
        self.title = videoTitle
        self.url = videoUrl
        self.views = videoViews!
    }
}

public class category{
    
    var description: String?
    var name:String?
    var url:String?
    
    init(Description:String? = nil, Name:String? = nil, Url:String? = nil){
        
        self.description = Description
        self.name = Name
        self.url = Url
    
    }
    
    
    



}
