//
//  LandingViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 3/8/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import UIKit
import VKSdkFramework

class LoginVKViewController: UIViewController, VKSdkDelegate, VKSdkUIDelegate {
    
    //var sdkInstance = VKSdk.initializeWithAppId("5278492")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      //  sdkInstance.registerDelegate(self)
      //  VKSdk.initializeWithAppId("5278492")
      //  VKSdk.registerDelegate(self)
        
        let sdkInstance = VKSdk.initializeWithAppId("5278492")
        sdkInstance.registerDelegate(self)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authorize() {
        print("clicked the authorize button")
        
        VKSdk.authorize(["friends"])
        
        
        
        
        
//        if(VKSdk.vkAppMayExists()) {
//            print("I have the app")
//           // VKSdk.authorize(["friends"])
//        } else {
//            print("I don't have the app")
//            VKSdk.authorize(["friends"], withOptions: VKAuthorizationOptions.DisableSafariController)
//           // VKSdk.authorize(["friends"], withOptions: [revokeAccess:true, forceOAuth:true, inApp:true])
//        }
    }
    
    // MARK: Other VK stuff
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        print("Inside VK application")
        VKSdk.processOpenURL(url, fromApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey]! as! String)
        return true
    }
    
    // MARK: VKDelegate
    
    /**
    Notifies delegate about authorization was completed, and returns authorization result which presents new token or error.
    @param result contains new token or error, retrieved after VK authorization
    */
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        print("In vkSdkAccessAuthorizationFinishedWithResult")
        let token = result.token
        let vkUser = result.user
        print("\(token) \(vkUser)")
    }
    
    /**
     Notifies delegate about access error, mostly connected with user deauthorized application
     */
    func vkSdkUserAuthorizationFailed() {
        print("In Authorization failed")
        
    }
    
    /**
     Notifies delegate about access token changed
     @param newToken new token for API requests
     @param oldToken previous used token
     */
    func vkSdkAccessTokenUpdated(newToken: VKAccessToken!, oldToken: VKAccessToken!) {
        print("Received updated token")
    }
    
    /**
     Notifies delegate about existing token has expired
     @param expiredToken old token that has expired
     */
    func vkSdkTokenHasExpired(expiredToken: VKAccessToken!) {
        print("in vkSdkTokenHasExpired")
        self.authorize()
    }
    
    
    // MARK: VKUIDelegate
    
    /**
    Pass view controller that should be presented to user. Usually, it's an authorization window
    @param controller view controller that must be shown to user
    */
    func vkSdkShouldPresentViewController(controller: UIViewController!) {
        print("In vkSdkShouldPresentViewController")
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    /**
     Calls when user must perform captcha-check
     @param captchaError error returned from API. You can load captcha image from <b>captchaImg</b> property.
     After user answered current captcha, call answerCaptcha: method with user entered answer.
     */
    func vkSdkNeedCaptchaEnter(captchaError: VKError!) {
        print("In vkSdkNeedCaptchaEnter")
        let captchaView:VKCaptchaViewController = VKCaptchaViewController.captchaControllerWithError(captchaError)
        captchaView.presentIn(self)
    }
    
    
    
    
}