//
//  LandingViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 3/8/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import UIKit
import VKSdkFramework
import Parse
import ParseUI

class LoginVKViewController: UIViewController, VKSdkDelegate, VKSdkUIDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    let vkInstance = VKSdk.initializeWithAppId("5278492")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkInstance.registerDelegate(self)
        vkInstance.uiDelegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (PFUser.currentUser() == nil) {
            let loginViewController = LoginViewController()
            loginViewController.delegate = self
            
            loginViewController.fields = [.UsernameAndPassword, .PasswordForgotten, .LogInButton, .Facebook, .SignUpButton, .DismissButton]
            loginViewController.emailAsUsername = true
            loginViewController.signUpController?.emailAsUsername = true
            loginViewController.signUpController?.delegate = self
            
            loginViewController.signUpController?.delegate = self
            self.presentViewController(loginViewController, animated: false, completion: nil)
        } else {
            presentLoggedInAlert()
        }
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "Welcome to My Motto", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authorize() {
        print("*** Clicked the authorize button")
        
        let scope = ["status"]
        
        if VKSdk.vkAppMayExists () {
            print("*** App may exist")
            VKSdk.authorize (scope)
        } else {
            // Do modal view here.
            VKSdk.authorize (scope)
            print("*** App does not exist")
        }
    }

    // MARK: VK Delegate methods
    
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        print("*** VK Authorization finished")
        let accessToken = VKSdk.accessToken()
        let userId = accessToken.userId
        print("\(userId)")
        
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
    
    // MARK: Parse LoginDelegate
    
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
//
//    /**
//     * Called when a controller presented by SDK will be dismissed
//     */
//    @available(iOS 2.0, *)
//    optional public func vkSdkWillDismissViewController(controller: UIViewController!)
//    
//    /**
//     * Called when a controller presented by SDK did dismiss
//     */
//    @available(iOS 2.0, *)
//    optional public func vkSdkDidDismissViewController(controller: UIViewController!)
    

}