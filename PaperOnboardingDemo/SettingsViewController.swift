//
//  SettingsViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/7/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit
import Crashlytics
import Firebase
import FirebaseAuth


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
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
