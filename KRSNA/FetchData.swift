//
//  FetchData.swift
//  KRSNA
//
//  Created by Kush Taneja on 06/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import Foundation
import Firebase

class FetchData {
    let ref: FIRDatabaseReference! = FIRDatabase.database().reference()
    
    func updateAndReturnVrindavanSection(for tableView: UITableView) -> [post] {
            var posts = [post]()
            let vrindavan_head = ref.child("new_vrindavan").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
                
            let output = snapshot.value as? NSDictionary
            let description = output?["description"] as? String
            let title = output?["title"] as? String
            let key = output?["key"] as? Int
            let likes = output?["likes"] as? Int
            let shares = output?["shares"] as? Int
            let url = output?["url"] as? String
            let views = output?["views"] as? Int
            let currentPost = post(postDescription: description, postKey: key, postLikes: likes, postShares: shares, postTitle: title, postUrl: url, postViews: views)
            posts.insert(currentPost, at: posts.count)
//            debugPrint("\(currentPost.title) Post Added")
            tableView.reloadData()
            }) { (error) in
                print(error.localizedDescription)
        }
        
            return posts
        }
    
}

