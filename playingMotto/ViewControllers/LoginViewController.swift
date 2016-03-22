//
//  LoginViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 3/15/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import Parse
import ParseUI
import UIKit
import VKSdkFramework

class LoginViewController :  PFLogInViewController, VKSdkDelegate, VKSdkUIDelegate {
    
    var backgroundImage : UIImageView!;
    let vkInstance = VKSdk.initializeWithAppId("5278492")
    let passwordLen = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkInstance.registerDelegate(self)
        vkInstance.uiDelegate = self
        
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
        customizeButton(logInView?.facebookButton!)
        customizeButton(logInView?.signUpButton!)
        
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
        logInView?.facebookButton?.setTitle("Log In with VKontakte", forState: .Normal)
        logInView?.facebookButton?.setImage(UIImage(named: "vkLogoRoundEdgeSMALL"), forState: .Normal)
        logInView?.facebookButton?.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        logInView?.facebookButton?.addTarget(self, action: "authorizeVK:", forControlEvents: UIControlEvents.TouchUpInside)
        
        logInView?.passwordForgottenButton?.setTitleColor(UIColor.grayColor(), forState: .Normal)
    }
    
    
    func authorizeVK(sender: UIButton!) {
        print("*** Clicked the authorize button")
        
        
        let scope = ["status,email"]
        
        if VKSdk.vkAppMayExists () {
            print("*** App may exist")
            VKSdk.authorize (scope)
        } else {
            // Do modal view here.
            VKSdk.authorize (scope)
            print("*** App does not exist")
        }
    }
    
    func customizeButton(button: UIButton!) {
        button.setBackgroundImage(nil, forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    // MARK: VK Delegate methods
    
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        print("*** VK Authorization finished")
        
        let accessToken = VKSdk.accessToken()
        let vkAccessTokenString = accessToken.accessToken
        let vkUserId = accessToken.userId
        let vkEmail = accessToken.email
        print("\(vkUserId)")
        print("\(vkEmail)")
        
        // Create PFUser and sign him/her up
        let mottoUser = PFUser()
        mottoUser.username = vkUserId
        // TODO: If no email from VK, maybe register their userid@vkmotto.com
        mottoUser.email = vkEmail
        mottoUser.password = Utilities.randomAlphaNumericString(passwordLen)
        mottoUser["accessToken"] = vkAccessTokenString
        
        // Query Parse for user
        let query = PFUser.query()
        query!.whereKey("email", equalTo:vkEmail)
        query!.limit = 1
        var scoutVKUser: [PFObject]? = nil
        
        do {
            scoutVKUser = try query?.findObjects()
        } catch {
            print("Some error occured with query")
        }
        
        // If no user in our ParseServer, then go ahead and sign him/her up
        if scoutVKUser?.count == 0 {
            
            mottoUser.signUpInBackgroundWithBlock({
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    print("\(errorString)")
                } else {
                    print("Hooray! Let them use the app now.")
                    self.signUpController?.delegate?.signUpViewController!(self.signUpController!, didSignUpUser: mottoUser)
                }
            })
        } else {
            
            print ("User exists - Unimplemented feature")
            // TODO
            // User already logged in with VK, thus there is a parseSessionToken stored in mongoDB.
            // Thus, let's retrieve this token and log in user.
//            let scoutVKUsername = scoutVKUser?.first?.objectForKey("username") as! String
//            let scoutVKUSerpass = scoutVKUser?.first?.objectForKey("password") as! String
//            
//            // Now log this user in
//            PFUser.logInWithUsernameInBackground(scoutVKUsername, password:scoutVKUSerpass) {
//                (user: PFUser?, error: NSError?) -> Void in
//                if user != nil {
//                    print("Hooray! Let them use the app now.")
//                } else {
//                    print("Log in failed, do something")
//                }
//            }
        }
        
        // Then check for session in each view controller
        // Fix start screen, landing screen, so that after login you arrive at start screen
        // Do logout. Let's be done by 5 PM.
    }
    
    /**
     Notifies delegate about access error, mostly connected with user deauthorized application
     */
    func vkSdkUserAuthorizationFailed() {
        print("*** VK Authorization failed")
    }
    
    func vkSdkShouldPresentViewController(controller: UIViewController!){
        print("*** VK In vkSdkShouldPresentViewController")
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    
    func vkSdkNeedCaptchaEnter(captchaError: VKError!) {
        print("*** VK In vkSdkNeedCaptchaEnter")
    }

    
}