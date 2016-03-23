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
        
        var myUser: VKUser? = nil

        let imageVKRequest = VKApi.users().get()
        imageVKRequest.executeWithResultBlock({
            (response: VKResponse!) -> Void in
            
            myUser = (response!.parsedModel as! VKUsersArray).firstObject() as? VKUser
            
            }, errorBlock: {(error: NSError!) -> Void in
                
                print("\(error)")
                
        })
        
        print("\(myUser?.photo_50)")
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: VK
    
    
//    [[[VKApi users] get:@{ VK_API_FIELDS : @"id,first_name,last_name,sex,bdate,city,country,photo_50,photo_100,photo_200_orig,photo_200,photo_400_orig,photo_max,photo_max_orig,online,online_mobile,lists,domain,has_mobile,contacts,connections,site,education,universities,schools,can_post,can_see_all_posts,can_see_audio,can_write_private_message,status,last_seen,common_count,relation,relatives,counters" }]
//    executeWithResultBlock:^(VKResponse *response) {
//    VKUser * user = ((VKUsersArray*)response.parsedModel).firstObject;
//    NSLog(@"Любой другой параметр: %@", user.has_mobile);
//    } errorBlock:^(NSError *error) {
//    NSLog(@"Error: %@", error);
//    }];
    
    
}