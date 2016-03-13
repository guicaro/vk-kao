//
//  AppDelegate.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 2/19/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import UIKit
import VKSdkFramework
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Parse
        let configuration = ParseClientConfiguration {
            $0.applicationId = "itishotintexas"
            $0.clientKey = "itishotintexas"
            $0.server = "http://parseserver-9w2e3-env.us-west-2.elasticbeanstalk.com/parse"
        }
        Parse.initializeWithConfiguration(configuration)
        
        //Testing to see if we have network activity
        let testObj = PFObject.init(className: "Testing")
        testObj.addObject("iosblog", forKey: "websiteURL")
        testObj.saveInBackground()
        
        return true
    }
    
    // MARK: VK stuff here
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        print("*** Inside AppDelegate - VKSDK.processOpenURL")
        return VKSdk.processOpenURL(url, fromApplication: sourceApplication)
    }
    
}

