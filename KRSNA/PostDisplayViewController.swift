//
//  PostDisplayViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 06/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit
import SDWebImage
import SKPhotoBrowser

class PostDisplayViewController: UIViewController,UIScrollViewDelegate{
    
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
    var imageViews = [SKPhoto]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        //        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        //        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        
        self.postContentLabel?.text = postContent
        self.postTitleLabel?.text = postTitle
        self.postCategoryLabel?.text = postCategory
        self.postImageView.sd_setImage(with: URL(string: self.postUrl!)!, placeholderImage: #imageLiteral(resourceName: "Rectangle"))
        let photo = SKPhoto.photoWithImageURL(self.postUrl!)
        photo.shouldCachePhotoURLImage = true // you can use image cache by true(NSCache)
        self.imageViews.append(photo)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.ShowGalleryImageViewController(_:)))
         self.postImageView.isUserInteractionEnabled = true
         self.postImageView.addGestureRecognizer(tapGesture)
        
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
    
    func ShowGalleryImageViewController(_ sender: UITapGestureRecognizer) {
    
        let browser = SKPhotoBrowser(photos: imageViews)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})

    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}




