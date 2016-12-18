//
//  GitaPageMenuViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 17/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit

class GitaPageMenuViewController: UIViewController,CAPSPageMenuDelegate {
    var pageMenu : CAPSPageMenu?
    let storyBoard: UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
    var controllerArray : [UIViewController] = []
    var pageMenuCurrentIndex = 0
    var controller : UIViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // Making Page View Controllers
        controller = storyBoard.instantiateViewController(withIdentifier: "ListOfChatpersTableViewController")
        controller.title = "Chapters"
        controllerArray.append(controller)
        controller = storyBoard.instantiateViewController(withIdentifier: "AtaGlanceCollectionViewController")
        controller.title = "At a Glance"
        controllerArray.append(controller)
        controller = storyBoard.instantiateViewController(withIdentifier: "Gita_AboutViewController")
        controller.title = "About"
        controllerArray.append(controller)
        
        // Parameters for PageMenu
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
