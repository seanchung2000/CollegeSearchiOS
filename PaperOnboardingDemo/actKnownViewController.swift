//
//  actKnownViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 4/1/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase
import SVProgressHUD

class actKnownViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TESTING")
        if  Auth.auth().currentUser != nil {
            print("Logged In")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
