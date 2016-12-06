//
//  PostDisplayViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 06/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit
import SDWebImage

class PostDisplayViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var postCategoryLabel: UILabel!
    
    @IBOutlet weak var postContentLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var postTitle: String?
    var postCategory: String?
    var postContent: String?
    var postUrl: String?
    var contentRect = CGRect.zero

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postContentLabel?.text = postContent
        self.postTitleLabel?.text = postTitle
        self.postCategoryLabel?.text = postCategory
        self.postImageView.sd_setImage(with: NSURL(string: self.postUrl!) as URL!, placeholderImage: #imageLiteral(resourceName: "Rectangle"))
        
        for view in self.scrollView.subviews {
            contentRect.union(view.frame)
        }
        self.scrollView.contentSize = contentRect.size
        self.scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
            /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
