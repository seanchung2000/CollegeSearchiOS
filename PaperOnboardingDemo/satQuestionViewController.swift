//
//  satQuestionViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 3/29/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit
import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseFirestore
import Foundation
import Crashlytics
import SVProgressHUD


class satQuestionViewController: UIViewController {

    @IBOutlet weak var yetButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func noButtonTapped(_ sender: Any) {
        let userID: String = (Auth.auth().currentUser?.uid)!
        let db = Firestore.firestore()
        db.collection("Users").document("\(userID)").collection("SAT").document("0").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        db.collection("Users").document("\(userID)").collection("SAT").document("\(1)").setData([
            "SAT": "\(1)"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
        }
    }
}
