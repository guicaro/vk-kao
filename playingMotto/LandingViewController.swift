//
//  LandingViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 3/8/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import UIKit
import VKSdkFramework

class LandingViewController: UIViewController {
    
    var sdkInstance = VKSdk.initializeWithAppId("5278492")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // TODO: Memo, I don't think you need this, because you can retrieve the token from PARSE and then check if
        //        it is VKAuthorizationAuthorized
        // if( token.permissions == VKAuthorizationState.Authorized)
        //     // THEN ALL STUFF HERE
        
        
//        VKSdk.wakeUpSession(["friends", "email"], completeBlock: <#T##((VKAuthorizationState, NSError!) -> Void)!##((VKAuthorizationState, NSError!) -> Void)!##(VKAuthorizationState, NSError!) -> Void#>)
//            {
//                if (state == VKAuthorizationAuthorized) {
//                    print("I'm in")
//                }
//                else if (error) {
//                    print("bad")
//                }
//        }
//            
//        [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
//        if (state == VKAuthorizationAuthorized) {
//        // Authorized and ready to go
//        } else if (error) {
//        // Some error happend, but you may try later
//        }
//        }];
        
        
        //sdkInstance.registerDelegate(self)
        
        //
       // VKSdk.authorize([VK_PER_AUDIO, VK_PER_OFFLINE])
        
       // http://oauth.vk.com/authorize?client_id=5278492&scope=status&redirect_uri=https://oauth.vk.com/blank.html&v=5.45&response_type=token
        
       // 55346001 - memo vk user
        
        //    var sdkInstance = VKSdk.initializeWithAppId("5278492")

        //VKSdk.initializeWithAppId("5278492")
        
//        [VKSdk initializeWithDelegate:delegate andAppId:YOUR_APP_ID];
//        if ([VKSdk wakeUpSession])
//        {
//            //Start working
//        } 

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    // Maybe implemente the AppDelegate?
    
    
    //TODO VK, is there a previous session available?
    // MAybe this is something we can do with PARSE?
    
    
//    NSArray *SCOPE = @[@"friends", @"email"];
//    
//    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
//    if (state == VKAuthorizationAuthorized) {
//    // Authorized and ready to go
//    } else if (error) {
//    // Some error happend, but you may try later
//    }
//    }];
    
//    [VKSdk initializeWithDelegate:delegate andAppId:YOUR_APP_ID];
//    if ([VKSdk wakeUpSession])
//    {
//    //Start working
//    }
    
    
}