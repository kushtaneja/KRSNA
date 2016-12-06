//
//  ExploreTableViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 06/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase

class ExploreTableViewController: UITableViewController {
    var posts = [post]()
    var vrindavanPosts = [post]()
    var ref: FIRDatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.updateAndReturnVrindavanSection()
        ActivityIndicator.shared.showProgressView(uiView: view)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    /*
     override func viewWillAppear(_ animated: Bool) {
     
     super.viewWillAppear(true)
     
     
     }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vrindavanPosts.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoriesTableViewCell", for: indexPath) as! StoriesTableViewCell
        let post: post = vrindavanPosts[indexPath.row]
        debugPrint("\(post.title) postAddedtoTableView")
        cell.postTitleLabel.text = post.title
        cell.postDescriptionLabel.text = post.description
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(integerLiteral: 80)
        return height
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Firebase Functions
    //    func configDatabase(){
    //        ref = FIRDatabase.database().reference()
    //        let vrindavan_head = ref.child("new_vrindavan").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
    //            // Get user value
    ////            self.dataoutput = (snapshot.value as? [[String:Any]])!
    //
    //            let output = snapshot.value as? NSDictionary
    //            let description = output?["description"] as? String
    //            let title = output?["title"] as? String
    //            self.posts.insert(post(postDescription: description, postTitle: title), at: self.posts.count)
    //            self.tableView.reloadData()
    //            debugPrint("postAdded")
    //
    //        }) { (error) in
    //            print(error.localizedDescription)
    //        }
    //}
    
    
    func updateAndReturnVrindavanSection(){
        
        ref = FIRDatabase.database().reference()
        let vrindavan_head = ref.child("new_explorelist").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
            
            let output = snapshot.value as? NSDictionary
            let description = output?["description"] as? String
            let title = output?["title"] as? String
            let key = output?["key"] as? Int
            let likes = output?["likes"] as? Int
            let shares = output?["shares"] as? Int
            let url = output?["url"] as? String
            let views = output?["views"] as? Int
            let currentPost = post(postDescription: description, postKey: key, postLikes: likes, postShares: shares, postTitle: title, postUrl: url, postViews: views)
            self.vrindavanPosts.insert(currentPost, at: self.vrindavanPosts.count)
            debugPrint("\(currentPost.title) Post Added")
            self.tableView.reloadData()
            ActivityIndicator.shared.hideProgressView()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}
