//
//  LibraryViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 01/02/17.
//  Copyright © 2017 Kush Taneja. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController,CAPSPageMenuDelegate{
    var pageMenu : CAPSPageMenu?
    let storyBoard: UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
    var controllerArray : [UIViewController] = []
    var pageMenuCurrentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Making Page View Controllers
        self.navigationItem.title = "Library"
        var controller : UIViewController = UIViewController()
        self.view.backgroundColor = UIColor.white
        
        controller = storyBoard.instantiateViewController(withIdentifier: "MusicTableViewController")
        controller.title = "Music"
        controllerArray.append(controller)
        controller = storyBoard.instantiateViewController(withIdentifier: "VideosTableViewController")
        controller.title = "Videos"
        controllerArray.append(controller)
        controller = storyBoard.instantiateViewController(withIdentifier: "GalleryTableViewController")
        controller.title = "Gallery"
        controllerArray.append(controller)
        controller = storyBoard.instantiateViewController(withIdentifier: "BooksTableViewController")
        controller.title = "Books"
        controllerArray.append(controller)
        
        
        
        let parameters: [CAPSPageMenuOption] = [
            .menuHeight(40.0),
            .menuItemSeparatorWidth(0.0),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .scrollMenuBackgroundColor(ColorCode().pageMenuBackgroundColor),
            .selectionIndicatorColor(ColorCode().linksBlueColor),
            .unselectedMenuItemLabelColor(UIColor.white.withAlphaComponent(0.5)),
            .selectedMenuItemLabelColor(UIColor.white),
            .selectedItemBackgroundColor(UIColor.clear),
            .unSelectedMenuItemBackgroundColor(UIColor.clear),
            .canChangePageOnHorizontalScroll(true),
            .addBottomMenuHairline(true),
            .bottomMenuHairlineColor(UIColor.white)
            
        ]
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame:  CGRect(x: 0.0, y: 0.0
            , width: self.view.frame.width, height: self.view.frame.height - 30.0
        ), pageMenuOptions: parameters)
        
        //pageMenu?.menuItemFont = UIFont(name: "Roboto-Regular", size: 15)!
        pageMenu?.view.backgroundColor = UIColor.clear
        pageMenu?.delegate = self
        self.view.addSubview(pageMenu!.view)
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
    }

    
    
    
    
    // MARK:- PageMenu Functions
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        
        pageMenuCurrentIndex = index
        
        switch pageMenuCurrentIndex{
        case 0:
            print("@@@@@@@@ EXPLORE")
        case 1:
            print("@@@@@@@@ LOOK UP")
            
        default:
            break
        }
        
    }
    
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        pageMenuCurrentIndex = index
        
        switch pageMenuCurrentIndex{
        case 0:
            print("@@@@@@@@ WILL EXPLORE")
        case 1:
            print("@@@@@@@@ WILL LOOK UP")
        default:
            break
        }
    }

}
