//
//  NewMottoViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 2/19/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import UIKit
import VKSdkFramework
import Parse

class NewMottoViewController: UIViewController {

    @IBOutlet weak var mottoTextBox: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func sendMotto(sender: UIButton) {
        print("button was pressed")
        print("\(mottoTextBox.text)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mottoTextBox.clearsOnInsertion = true
        
        
        // Storing object (Testing becomes the collection name on mongoDB)
        let testObj = PFObject.init(className: "Testing")
        
        testObj.addObject("iosblog", forKey: "websiteURL")
        testObj.saveInBackground()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

