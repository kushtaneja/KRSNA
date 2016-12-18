//
//  Extensions.swift
//  Eazespot
//
//  Created by Kush Taneja on 02/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    class func KRSNAMainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    
    class func postDisplayNavigationScreen() -> UINavigationController {
        return (KRSNAMainStoryboard().instantiateViewController(withIdentifier: "PostDisplayNavigationController") as? UINavigationController)!
        
    }
    
    class func AllPostsNavigationScreen() -> UIViewController {
        return KRSNAMainStoryboard().instantiateViewController(withIdentifier: "AllPostsNavigationController")
    }
    
    class func ChapterVersesListScreen() -> UIViewController {
        return KRSNAMainStoryboard().instantiateViewController(withIdentifier: "ChapterVersesTableViewController")
    }
    
    class func GitaNavigationScreen() -> UINavigationController {
            return (KRSNAMainStoryboard().instantiateViewController(withIdentifier: "GitaNavigationController") as? UINavigationController)!
        
    }

    
    
    
    
    
    

}

extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.characters.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
            
            return self[(startIndex..<endIndex)]
        }
    }
    
    func fromBase64() -> String {
        let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0))
        return String(data: data!, encoding: String.Encoding.utf8)!
    }
    
    func toBase64() -> String {
        let data = self.data(using: String.Encoding.utf8)
        return data!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
}
