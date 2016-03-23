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
        
        // Safeguard when user clicks DONE on modal view presented by VK
        let accessToken = VKSdk.accessToken()
        if (accessToken != nil) {
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
        mottoUser.password = Utilities.reverseString(vkUserId)
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
            
            // User already tried to log in using VK API, so we signed him in, thus, now let's just pick up the session
            // or log him/her in. Notice we know the password as we know the secret function when we sign him up in the
            // background.
            
            PFUser.logInWithUsernameInBackground(mottoUser.username!, password:mottoUser.password!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    print("Great, we can log in")
                    self.delegate?.logInViewController!(self, didLogInUser: mottoUser)

                } else {
                    print("Error while trying to log in an existing user.")
                }
            }
        }
        }
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