//
//  HomeVC.swift
//  
//
//  Created by Kunwar Sahni on 6/28/17.
//
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

//testing again

class HomeVC: UIViewController {
    
    /*let userID: String = (Auth.auth().currentUser?.uid)!
    
    let ref = Database.database().reference(withPath: userID)
    */
 
    @IBAction func logOutTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            presentLoggedInScreen()
            print("login screen presented") 
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginPageController:loginPageController = storyboard.instantiateViewController(withIdentifier: "loginPageController") as! loginPageController
        self.present(loginPageController, animated: true, completion: nil)
    }

}
