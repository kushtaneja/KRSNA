
//
//  VideosTableViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 01/02/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase

class VideosTableViewController: UITableViewController {
    
    var categoryArray = [category]()
    var ref = FIRDatabaseReference()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderHeight = CGFloat(integerLiteral: 0)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        insertVideoCategories()

    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let sectionHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 30.0))
        sectionHeaderView.layer.backgroundColor = UIColor.white.cgColor
        let label = UILabel(frame: CGRect(x: 15.0, y: 5.0, width: self.view.frame.width, height: 20.0))
        
        label.textColor = ColorCode().appThemeColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        label.text = "Categories"

        
        sectionHeaderView.addSubview(label)
        return sectionHeaderView
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Categories"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if categoryArray.count > 0 {
            tableView.sectionHeaderHeight = CGFloat(integerLiteral: 30)
            ActivityIndicator.shared.hideProgressView()
            return categoryArray.count
        }else{
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoriesTableViewCell", for: indexPath) as! StoriesTableViewCell
        let category: category = categoryArray[indexPath.row]
        cell.postTitleLabel.text = category.name
        cell.postDescriptionLabel.text = category.description
        cell.postThumbnailView.sd_setImage(with: NSURL(string: category.url!) as URL!, placeholderImage: #imageLiteral(resourceName: "Rectangle"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(integerLiteral: 80)
        return height
    }
    
    
    //MARK: Firebase Methods
    
    func insertVideoCategories(){
        ref  = FIRDatabase.database().reference()
        let vrindavan_head = ref.child("new_video").child("category").queryOrderedByKey().observe(.childAdded, with:  { (snapshot) in
            
            let output = snapshot.value as? NSDictionary
            let description = output?["description"] as? String
            let name = output?["name"] as? String
            let url = output?["url"] as? String
            
            let currentCategory = category(Description: description, Name: name, Url: url)
            self.categoryArray.append(currentCategory)
            
            self.tableView.reloadData()
            ActivityIndicator.shared.hideProgressView()
        }) { (error) in
            print(error.localizedDescription)
            
        }
        ActivityIndicator.shared.hideProgressView()
        
    }

    
    
}
