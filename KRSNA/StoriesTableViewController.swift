//
//  StoriesTableViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 26/11/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class StoriesTableViewController: UITableViewController {
    
    var posts = [post]()
    var vrindavanPosts = [post]()
    var mathuraPosts = [post]()
    var dwarkaPosts = [post]()
    let postImageView: UIImageView? = nil
    var ref = FIRDatabaseReference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderHeight = CGFloat(integerLiteral: 0)
        tableView.sectionFooterHeight = CGFloat(integerLiteral: 0)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.insert()
        
       
        
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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 30.0))
        sectionHeaderView.layer.backgroundColor = UIColor.white.cgColor
        let label = UILabel(frame: CGRect(x: 15.0, y: 5.0, width: self.view.frame.width, height: 20.0))
        
        label.textColor = ColorCode().appThemeColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
    
        switch section {
        case 0:
           label.text = "Stories from Vrindavan"
        case 1:
           label.text = "Stories from Mathura"
        case 2:
            label.text = "Stories from Dwarka"
        default:
           label.text = "Stories"
            
        }
        
        
        sectionHeaderView.addSubview(label)
            return sectionHeaderView
        }
  

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Stories from Vrindavan"
        case 1:
            return "Stories from Mathura"
        case 2:
            return "Stories from Dwarka"
        default:
            return "Stories"
            
        }

        }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (vrindavanPosts.count > 0 && mathuraPosts.count > 0 && dwarkaPosts.count > 0){
            tableView.sectionHeaderHeight = CGFloat(integerLiteral: 30)
            tableView.sectionFooterHeight = CGFloat(integerLiteral: 10)
            ActivityIndicator.shared.hideProgressView()
            return 4
        }
        else {
            
            return 0
        }
    }
    
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if (indexPath.section == 0){
            return configureCells(tableView: tableView, indexPath: indexPath, array: vrindavanPosts)
        
        }
        if (indexPath.section == 1){
            
             return configureCells(tableView: tableView, indexPath: indexPath,array: mathuraPosts)
        }
        if (indexPath.section == 2){
            return configureCells(tableView: tableView, indexPath: indexPath,array: dwarkaPosts)
        }
        else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadingStoriesTableViewCell", for: indexPath) 
            return cell
        
        }
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1,2:
            let height = CGFloat(integerLiteral: 80)
            return height
        case 3:
            let height = CGFloat(integerLiteral: 38)
            return height
        default:
           break
        }
        let height = CGFloat(integerLiteral: 44)
        return height
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 0){
            return configureCellActions(tableView: tableView, indexPath: indexPath, array: vrindavanPosts)
            
        }
        if (indexPath.section == 1){
            
            return configureCellActions(tableView: tableView, indexPath: indexPath, array: mathuraPosts)
        }
        if (indexPath.section == 2){
            return configureCellActions(tableView: tableView, indexPath: indexPath, array: dwarkaPosts)
        }
        
       
        
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
    private func configureCellActions(tableView: UITableView,indexPath: IndexPath, array: [post]){
        let postDisplayNavigationScreen = UIStoryboard.postDisplayNavigationScreen()
        let postDisplayScreen = postDisplayNavigationScreen.topViewController as! PostDisplayViewController
        switch indexPath.row {
        case 0,1,2:
            postDisplayScreen.postCategory = self.tableView(tableView, titleForHeaderInSection: indexPath.section)?.uppercased()
            postDisplayScreen.postTitle = array[indexPath.row].title
            postDisplayScreen.postContent = array[indexPath.row].description
            postDisplayScreen.postUrl =  array[indexPath.row].url
            
           UIApplication.topViewController()?.present(postDisplayNavigationScreen, animated: true, completion: nil)
            
        case 3:
            let allPostNavigationScreen = UIStoryboard.AllPostsNavigationScreen() as! UINavigationController
            let allPostScreen = allPostNavigationScreen.topViewController as! AllPostsDisplayTableViewController
            
            allPostScreen.postArray = array
            allPostScreen.navigationItem.title = self.tableView(tableView, titleForHeaderInSection: indexPath.section)
            

            UIApplication.topViewController()?.present(allPostNavigationScreen, animated: true, completion: nil)
            
            break
        default:
            break
        }
    }
      private func configureCells(tableView: UITableView,indexPath: IndexPath, array: [post])-> UITableViewCell {
        
            switch indexPath.row {
                case 0,1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "StoriesTableViewCell", for: indexPath) as! StoriesTableViewCell
                let post: post = array[indexPath.row]
                debugPrint("\(post.title) postAddedtoTableView")
                cell.postTitleLabel.text = post.title
                cell.postDescriptionLabel.text = post.description
                cell.postThumbnailView.sd_setImage(with: NSURL(string: post.url!) as URL!, placeholderImage: #imageLiteral(resourceName: "Rectangle"))
                return cell
                
                case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "StoriesTableViewCell", for: indexPath) as! StoriesTableViewCell
                let post: post = array[indexPath.row]
                debugPrint("\(post.title) postAddedtoTableView")
                cell.postTitleLabel.text = post.title
                cell.postDescriptionLabel.text = post.description
                cell.postThumbnailView.sd_setImage(with: NSURL(string: post.url!) as URL!, placeholderImage: #imageLiteral(resourceName: "Rectangle"))
                cell.separatorInset = UIEdgeInsets.init(top: 5.0, left: 0.0, bottom: 0.0, right: 0.0)
                return cell
                
                case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReadStoriesTableViewCell", for: indexPath) as! ReadStoriesTableViewCell
                cell.readTextLabel.text = "Read all Stories"
                cell.separatorInset = UIEdgeInsets.init(top: 0.0, left: self.view.frame.width, bottom: 0.0, right: 0.0)
                
                return cell
                
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReadStoriesTableViewCell", for: indexPath)
                return cell
       
        }
   
    }

    
    // MARK: - Firebase Functions

    func insertPost(postArray: [post], for head: String){
        
        var postArray = postArray
        let refi: FIRDatabaseReference = FIRDatabase.database().reference()
        let vrindavan_head = refi.child(head).queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
            
            let output = snapshot.value as? NSDictionary
            let description = output?["description"] as? String
            let title = output?["title"] as? String
            let key = output?["key"] as? Int
            let likes = output?["likes"] as? Int
            let shares = output?["shares"] as? Int
            let url = output?["url"] as? String
            let views = output?["views"] as? Int
            let currentPost = post(postDescription: description, postKey: key, postLikes: likes, postShares: shares, postTitle: title, postUrl: url, postViews: views)
            postArray.insert(currentPost, at: self.vrindavanPosts.count)
            debugPrint("\(currentPost.title) Post Added")
            
        }) { (error) in
            print(error.localizedDescription)
            
        }
    
    }
        func insert(){
        ref  = FIRDatabase.database().reference()
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
            self.vrindavanPosts.insert(currentPost, at: self.vrindavanPosts.count)
            debugPrint("\(currentPost.title) Post Added")
            

        }) { (error) in
            print(error.localizedDescription)
            
            }
            let mathura = ref.child("new_mathura").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
                
                let output = snapshot.value as? NSDictionary
                let description = output?["description"] as? String
                let title = output?["title"] as? String
                let key = output?["key"] as? Int
                let likes = output?["likes"] as? Int
                let shares = output?["shares"] as? Int
                let url = output?["url"] as? String
                let views = output?["views"] as? Int
                let currentPost = post(postDescription: description, postKey: key, postLikes: likes, postShares: shares, postTitle: title, postUrl: url, postViews: views)
                self.mathuraPosts.insert(currentPost, at: self.mathuraPosts.count)
                debugPrint("\(currentPost.title) Post Added")
                
                
            }) { (error) in
                print(error.localizedDescription)
                
            }
        
            let dwarka_head = ref.child("new_dwarka").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
                
                let output = snapshot.value as? NSDictionary
                let description = output?["description"] as? String
                let title = output?["title"] as? String
                let key = output?["key"] as? Int
                let likes = output?["likes"] as? Int
                let shares = output?["shares"] as? Int
                let url = output?["url"] as? String
                let views = output?["views"] as? Int
                let currentPost = post(postDescription: description, postKey: key, postLikes: likes, postShares: shares, postTitle: title, postUrl: url, postViews: views)
                self.dwarkaPosts.insert(currentPost, at: self.dwarkaPosts.count)
                debugPrint("\(currentPost.title) Post Added")
                self.tableView.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
                
            }
            
            self.tableView.reloadData()
            ActivityIndicator.shared.hideProgressView()
        
        }

}
