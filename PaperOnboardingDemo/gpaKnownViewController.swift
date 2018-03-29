//
//  gpaKnownViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 3/29/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseFirestore
import Foundation
import Crashlytics
import SVProgressHUD
import CoreData

class gpaKnownViewController: UIViewController {

    @IBOutlet weak var gpaTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentReachabilityStatus == .notReachable {
            SVProgressHUD.show(withStatus: "Not Connected to Internet")
            
        } else if currentReachabilityStatus == .reachableViaWiFi{
            SVProgressHUD.dismiss()
        } else if currentReachabilityStatus == .reachableViaWWAN{
            SVProgressHUD.dismiss()
        } else {
            print("Error")
        }
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        if gpaTextField.text == "" {
            self.createAlert(titleText: "Error", messageText: "No Weighted GPA Entered")
        } else {
            let userID: String = (Auth.auth().currentUser?.uid)!
            let db = Firestore.firestore()
            db.collection("Users").document("\(userID)").collection("GPA").document("0").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            db.collection("Users").document("\(userID)").collection("GPA").document("\(gpaTextField.text!)").setData([
                "GPA": "\(gpaTextField.text!)"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    func createAlert (titleText : String , messageText: String) {
        
        let alert = UIAlertController (title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
