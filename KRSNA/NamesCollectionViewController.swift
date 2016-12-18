//
//  NamesCollectionViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 14/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SKPhotoBrowser

private let reuseIdentifier = "NamesCollectionViewCell"
class NamesCollectionViewController: UICollectionViewController{
    var postKey:String?
    var myarray = [String]()
    var images = [SKPhoto]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicator.shared.showProgressView(uiView: self.view)
        let ref = FIRDatabase.database().reference()
        ref.child("new_names").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
            self.postKey = snapshot.key
            FIRDatabase.database().reference().child("new_names").child((self.postKey)!).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
                let output = snap.value as? NSDictionary
                let imageUrl = output?["url"] as? String
                debugPrint("IMAGE URL**\(imageUrl!)")
                self.myarray.append(imageUrl!)
                
                self.collectionView?.reloadData()
                
                let photo = SKPhoto.photoWithImageURL(imageUrl!)
                photo.shouldCachePhotoURLImage = true // you can use image cache by true(NSCache)
                self.images.append(photo)
                
            },withCancel: { (error) in
                print(error.localizedDescription)
            })
            print("ARRAAAYY:  \(self.myarray.count)")
            ActivityIndicator.shared.hideProgressView()
        } ,withCancel: { (error) in
            print(error.localizedDescription)
        })
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return myarray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        //        cell.backgroundColor = UIColor.gray
        cell.thumbnailView?.sd_setImage(with: URL(string:myarray[indexPath.row])!, placeholderImage: #imageLiteral(resourceName: "Rectangle"))
        
        // Configure the cell
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(indexPath.row)
        present(browser, animated: true, completion: {})
    }
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}





extension NamesCollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellLength = UIScreen.main.bounds.size.width*0.5-CGFloat(10.0)
        
        let width:Double = Double(cellLength)
        let height:Double = Double(cellLength)
        return CGSize(width: width, height: height)
        
        
    }
    
}

