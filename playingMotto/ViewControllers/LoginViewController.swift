//
//  LoginViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 3/15/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import ParseUI
import UIKit
import VKSdkFramework

class LoginViewController : PFLogInViewController {
    
    var backgroundImage : UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set our custom background image
        backgroundImage = UIImageView(image: UIImage(named: "woodwhite"))
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.logInView!.insertSubview(backgroundImage, atIndex: 0)
        
        // remove the parse Logo
        let logo = UILabel()
        logo.text = "My Motto"
        logo.textColor = UIColor.blackColor()
        logo.font = UIFont(name: "Pacifico", size: 70.0)
        logo.shadowColor = UIColor.lightGrayColor()
        logo.shadowOffset = CGSizeMake(2, 2)
        logInView?.logo = logo
        
        // Change color of button
        logInView?.logInButton?.setBackgroundImage(nil, forState: .Normal)
        logInView?.logInButton?.backgroundColor = UIColor(red: 66/255, green: 187/255, blue: 179/255, alpha: 1)
        
        logInView?.dismissButton?.hidden = true
        
        // make the buttons classier
        //customizeButton(logInView?.facebookButton!)
        //customizeButton(logInView?.twitterButton!)
        //customizeButton(logInView?.signUpButton!)
        
        self.signUpController = SignUpViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // stretch background image to fill screen
        backgroundImage.frame = CGRectMake( 0,  0,  self.logInView!.frame.width,  self.logInView!.frame.height)
        logInView!.logo!.sizeToFit()
        
        let logoFrame = logInView!.logo!.frame
        logInView!.logo!.frame = CGRectMake(logoFrame.origin.x, logInView!.usernameField!.frame.origin.y - logoFrame.height - 16, logInView!.frame.width,  logoFrame.height)
        
        logInView?.signUpButton?.setTitle("Register", forState: .Normal)
        logInView?.passwordForgottenButton?.setTitleColor(UIColor.grayColor(), forState: .Normal)        
        
    }
    
    
    func customizeButton(button: UIButton!) {
        button.setBackgroundImage(nil, forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
}