
//
//  MusicTableViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 01/02/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class MusicTableViewController: UITableViewController {
    
    var types = [String:[SongClassifier]]()
    var ref = FIRDatabaseReference()
    var isCategoryCollection: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderHeight = CGFloat(integerLiteral: 0)
        tableView.sectionFooterHeight = CGFloat(integerLiteral: 0)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.insert()
        
        
        
        ActivityIndicator.shared.showProgressView(uiView: view)
    }
 
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
            label.text = "Categories"
        case 1:
            label.text = "Genres"
        case 2:
            label.text = "Artists"
        default:
            label.text = "Music"
            
        }
        
        
        sectionHeaderView.addSubview(label)
        return sectionHeaderView
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Categories"
        case 1:
            return "Genres"
        case 2:
            return "Artists"
        default:
            return "Music"
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        tableView.sectionHeaderHeight = CGFloat(integerLiteral: 30)
        tableView.sectionFooterHeight = CGFloat(integerLiteral: 10)
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            let count = self.types["genre"]?.count != nil ? (self.types["genre"]?.count)! : 0
            if count == 0 {
                return 0
            }else{
                ActivityIndicator.shared.hideProgressView()
                return 6
            }
        default:
            return 0
        }
   
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            isCategoryCollection = true
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! MusicCategoryTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.reloadData()
            return cell
        case 1:
            isCategoryCollection = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! MusicCategoryTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.reloadData()
            return cell
        case 2:
            switch indexPath.row {
                
            case 0,1,2,3,4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! MusicArtistTableViewCell
                let artist = self.types["artist"]?[indexPath.row]
                cell.nameLabel.text = artist?.name
                cell.displayImageView.sd_setImage(with: URL(string:(artist?.imageUrl)!)!,placeholderImage: #imageLiteral(resourceName: "Rectangle"))
                cell.clipsToBounds = true
                
                cell.displayImageView.layer.cornerRadius = cell.displayImageView.frame.width*0.5
                
                return cell
                
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllArtistCell", for: indexPath) as! ReadStoriesTableViewCell
                cell.readTextLabel.text = "See all"
                return cell
                
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! MusicArtistTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            if indexPath.row == 5 {
                
                let artistNavigationScreen = UIStoryboard.allArtistScreen()
                let allArtistScreen = artistNavigationScreen.topViewController as! AllArtistsTableViewController
                
                allArtistScreen.artists = self.types["artist"]!
                
               UIApplication.topViewController()?.present(artistNavigationScreen, animated: true, completion: nil)
            
            }else{
            
                let cell = tableView.cellForRow(at: indexPath) as! MusicArtistTableViewCell
                
                let songNavScreen = UIStoryboard.songListNavigationScreen()
                let songListScreen = songNavScreen.topViewController as! SongsTableViewController
                
                songListScreen.type = MusicType.artist
                songListScreen.typeTitle = cell.nameLabel.text!
                songListScreen.typeName = "artist"
                songListScreen.fromOuter = true
                UIApplication.topViewController()?.present(songNavScreen, animated: true, completion: nil)
            
            
            }
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0,1:
            let height = CGFloat(integerLiteral: 96)
            return height
        case 2:
            switch indexPath.row {
            case 0,1,2,3,4:
                let height = CGFloat(integerLiteral: 60)
                return height
            default:
                let height = CGFloat(integerLiteral: 33)
                return height
            }
        default:
            let height = CGFloat(integerLiteral: 33)
            return height
        }
      
    }
    
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
           // postArray.insert(currentPost, at: self.vrindavanPosts.count)
            debugPrint("\(currentPost.title) Post Added")
            
        }) { (error) in
            print(error.localizedDescription)
            
        }
        
    }
    
    func insert(){
        self.types["category"] = []
        self.types["genre"] = []
        self.types["artist"] = []
        ref  = FIRDatabase.database().reference()
        let vrindavan_head = ref.child("new_music").child("type").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
            
            let output = snapshot.value as? NSDictionary
            
            
            let type = output?["type"] as? String
            
           // debugPrint("******** \(type)")
            
            if type! == "category" {
                self.types["category"]?.append(SongClassifier(classifierType: MusicType.category, classifierName: output?["name"] as? String, classifierImageUrl: output?["url"] as? String))
                
            }else if type! == "genre" {
                   self.types["genre"]?.append(SongClassifier(classifierType: MusicType.genre, classifierName: output?["name"] as? String, classifierImageUrl: output?["url"] as? String))
            
            }else if type! == "artist"{
                   self.types["artist"]?.append(SongClassifier(classifierType: MusicType.artist, classifierName: output?["name"] as? String, classifierImageUrl: output?["url"] as? String))
      
            }
            debugPrint("Category ** \((self.types["category"]?.count)!) \n Genre ** \((self.types["genre"]?.count)!) \n Artist ** \((self.types["artist"]?.count)!) \n")
                self.tableView.reloadData()
            ActivityIndicator.shared.hideProgressView()
        }) { (error) in
            print(error.localizedDescription)
            
        }
        ActivityIndicator.shared.hideProgressView()
        
    }


}

// MARK: CollectionVeiw Extension
extension MusicTableViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(isCategoryCollection){
        let width:Double = Double(75.0)
        let height:Double = Double(75.0)
            return CGSize(width: width, height: height)
        }else{
            let width:Double = Double(110.0)
            let height:Double = Double(75.0)
            return CGSize(width: width, height: height)
            
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if(isCategoryCollection){
            let count = self.types["category"]?.count != nil ? (self.types["category"]?.count)! : 0
            return count
        
        }else{
            let count = self.types["genre"]?.count != nil ? (self.types["genre"]?.count)! : 0
            return count
        }
        
        
          }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedPageCollectionViewCell", for: indexPath) as! MusicCategoryCollectionViewCell
        
       
        if(isCategoryCollection){
            let category = self.types["category"]?[indexPath.row]
            cell.type = MusicType.category
            cell.categoryImageView.sd_setImage(with: URL(string:(category?.imageUrl!)!)!, placeholderImage: #imageLiteral(resourceName: "Rectangle"))
            cell.categoryNameLabel.text = category?.name
            
        }else{
            let genre = self.types["genre"]?[indexPath.row]
            cell.type = MusicType.genre
            cell.categoryImageView.sd_setImage(with: URL(string:(genre?.imageUrl!)!)!, placeholderImage: #imageLiteral(resourceName: "Rectangle"))
            cell.categoryNameLabel.text = genre?.name
        }
        cell.categoryImageView.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let cell = collectionView.cellForItem(at: indexPath) as! MusicCategoryCollectionViewCell
        

            
            let songNavScreen = UIStoryboard.songListNavigationScreen()
            let songListScreen = songNavScreen.topViewController as! SongsTableViewController
            
        
            songListScreen.typeTitle = cell.categoryNameLabel.text!
        
            if (cell.type == .category){
                songListScreen.type = MusicType.category
                songListScreen.typeName = "category"
                
            }else if (cell.type == .genre){
                songListScreen.type = MusicType.genre
                songListScreen.typeName = "genre"
        
            }
            songListScreen.fromOuter = true
            
            UIApplication.topViewController()?.present(songNavScreen, animated: true, completion: nil)
            
       
    }
    
    
}



