//
//  LandingViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 3/8/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import UIKit
import VKSdkFramework

class LoginVKViewController: UIViewController, VKSdkDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VKSdk.initializeWithAppId("5278492").registerDelegate(self)
        //TODO: We might need to do something with UIDeleTgate
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authorize() {
        print("*** Clicked the authorize button")
        
        let scope = ["friends"]
        
        if VKSdk.vkAppMayExists () {
            print("*** App may exist")
            VKSdk.authorize (scope)
        } else {
            
            // Do modal view here.
            
            
            VKSdk.authorize (scope, withOptions: .DisableSafariController)
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
    

}