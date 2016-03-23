//
//  MyMottosViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 3/8/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import VKSdkFramework
import Parse
import UIKit

class MyMottosViewController: UIViewController {
    
    @IBAction func logout(sender: UIButton) {
        VKSdk.forceLogout()
        PFUser.logOut()
        
        // Create a segue
        self.performSegueWithIdentifier("backToLogin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}