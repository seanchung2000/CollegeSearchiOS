//
//  SettingsViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/7/18.
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

class SettingsViewController: UIViewController {

    @IBAction func websiteButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://interadaptive.com")! as URL, options: [:], completionHandler: nil)
    }
    @IBAction func logOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        showHomePage()
    }
    @IBAction func questionsPressed(_ sender: Any) {
        Answers.logCustomEvent(withName: "Feedback Pressed",
                               customAttributes: [:])
        UIApplication.shared.open(URL(string: "https://interadaptive.com/feedback")! as URL, options: [:], completionHandler: nil)
    }
    
    func showHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginPageController:loginPageController = storyboard.instantiateViewController(withIdentifier: "loginPageController") as! loginPageController
        self.present(loginPageController, animated: false, completion: nil)
    }
    @IBAction func resetYourScoresTapped(_ sender: Any) {
        let userID: String = (Auth.auth().currentUser?.uid)!
        let db = Firestore.firestore()
        db.collection("Users").document("\(userID)").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        db.collection("Users").document("\(userID)").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        db.collection("Users").document("\(userID)").collection("GPA").document("0").setData([
            "GPA": "0"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        db.collection("Users").document("\(userID)").collection("SAT").document("0").setData([
            "SAT": "0"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let FirstViewVCViewController:FirstViewVCViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewVCViewController") as! FirstViewVCViewController
        self.present(FirstViewVCViewController, animated: false, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
