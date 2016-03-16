//
//  SignUpViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 3/16/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import ParseUI
import UIKit
import VKSdkFramework

class SignUpViewController : PFSignUpViewController {
    
    var backgroundImage : UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set our custom background image
        backgroundImage = UIImageView(image: UIImage(named: "woodwhite"))
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.signUpView!.insertSubview(backgroundImage, atIndex: 0)
        
        // remove the parse Logo
        let logo = UILabel()
        logo.text = "My Motto"
        logo.textColor = UIColor.blackColor()
        logo.font = UIFont(name: "Pacifico", size: 70.0)
        logo.shadowColor = UIColor.lightGrayColor()
        logo.shadowOffset = CGSizeMake(2, 2)
        signUpView?.logo = logo
        
        // Change color of button
        signUpView?.signUpButton?.setBackgroundImage(nil, forState: .Normal)
        signUpView?.signUpButton?.backgroundColor = UIColor(red: 66/255, green: 187/255, blue: 179/255, alpha: 1)
        signUpView?.signUpButton?.setTitle("Register", forState: .Normal)
        
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        // change dismiss button to say 'Already registered?'
        signUpView?.dismissButton!.setTitle("Already registered?", forState: .Normal)
        signUpView?.dismissButton!.setImage(nil, forState: .Normal)
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImage.frame = CGRectMake( 0,  0,  signUpView!.frame.width,  signUpView!.frame.height)
        
        // position logo at top with larger frame
        signUpView!.logo!.sizeToFit()
        let logoFrame = signUpView!.logo!.frame
        signUpView!.logo!.frame = CGRectMake(logoFrame.origin.x, signUpView!.usernameField!.frame.origin.y - logoFrame.height - 16, signUpView!.frame.width,  logoFrame.height)
        
        // re-layout out dismiss button to be below sign
        let dismissButtonFrame = signUpView!.dismissButton!.frame
        signUpView?.dismissButton!.frame = CGRectMake(0, signUpView!.signUpButton!.frame.origin.y + signUpView!.signUpButton!.frame.height + 16.0,  signUpView!.frame.width,  dismissButtonFrame.height)
        
        signUpView?.dismissButton?.setTitleColor(UIColor.grayColor(), forState: .Normal)

        
    }
    
}
