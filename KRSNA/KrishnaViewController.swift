//
//  KrishnaViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 06/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit

class KrishnaViewController: UIViewController,CAPSPageMenuDelegate{
    
    var pageMenu : CAPSPageMenu?
    let storyBoard: UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
    var controllerArray : [UIViewController] = []
    var pageMenuCurrentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Making Page View Controllers
        var controller : UIViewController = UIViewController()
        
        controller = storyBoard.instantiateViewController(withIdentifier: "StoriesTableViewController")
        controller.title = "Stories"
        controllerArray.append(controller)
        controller = storyBoard.instantiateViewController(withIdentifier: "ExploreTableViewController")
        controller.title = "Explore"
        controllerArray.append(controller)
        controller = storyBoard.instantiateViewController(withIdentifier: "AboutTableViewController")
        controller.title = "About"
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
            .canChangePageOnHorizontalScroll(false),
            .addBottomMenuHairline(true),
            .bottomMenuHairlineColor(UIColor(rgb: 0xeeeeee))
            
        ]
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame:  CGRect(x: 0.0, y: 0.0
            , width: self.view.frame.width, height: self.view.frame.height - 60.0
        ), pageMenuOptions: parameters)
        
        //pageMenu?.menuItemFont = UIFont(name: "Roboto-Regular", size: 15)!
        pageMenu?.view.backgroundColor = UIColor.clear
        pageMenu?.delegate = self
        self.view.addSubview(pageMenu!.view)
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
