//
//  Post.swift
//  KRSNA
//
//  Created by Kush Taneja on 06/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import Foundation
class post {
    
    var description: String?
    var key: Int?
    var likes: Int?
    var shares: Int?
    var title: String?
    var url: String?
    var views: Int?

    init(postDescription: String?,postKey: Int?,postLikes: Int?,postShares: Int?,postTitle: String?,postUrl: String?,postViews: Int?) {
        
        description = postDescription
        key = postKey
        likes = postLikes
        shares = postShares
        title = postTitle
        url = postUrl
        views = postViews
    }
    init() {
    }
    init(postDescription: String?,postTitle: String?){
        description = postDescription
        title = postTitle
    }
}
