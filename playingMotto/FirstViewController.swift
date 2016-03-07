//
//  FirstViewController.swift
//  playingMotto
//
//  Created by Guillermo Cabrera on 2/19/16.
//  Copyright © 2016 Guillermo Cabrera. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

