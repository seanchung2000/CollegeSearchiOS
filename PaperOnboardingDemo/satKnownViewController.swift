//
//  satKnownViewController.swift
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

class satKnownViewController: UIViewController {

    @IBOutlet weak var satTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        if satTextField.text == "" {
            self.createAlert(titleText: "Error", messageText: "No SAT Score Entered")
        } else {
        let userID: String = (Auth.auth().currentUser?.uid)!
        let db = Firestore.firestore()
        db.collection("Users").document("\(userID)").collection("SAT").document("0").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        db.collection("Users").document("\(userID)").collection("SAT").document("\(satTextField.text)").setData([
            "SAT": "\(satTextField.text)"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func createAlert (titleText : String , messageText: String) {
        
        let alert = UIAlertController (title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
