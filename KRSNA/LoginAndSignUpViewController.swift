//
//  LoginAndSignUpViewController.swift
//  KRSNA
//
//  Created by Kush Taneja on 03/12/16.
//  Copyright © 2016 Kush Taneja. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class LoginAndSignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     FUIAuth.defaultAuthUI()?.providers = [FUIGoogleAuth()]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
