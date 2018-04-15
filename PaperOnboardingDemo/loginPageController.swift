//
//  loginPageController.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 6/28/17.
//  Copyright © 2017 Alex K. All rights reserved.
//


import UIKit
import FirebaseAuth
import Firebase
import Fabric
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase
import SVProgressHUD
import Taplytics
import UserNotifications
class loginPageController: UIViewController, UITextFieldDelegate {
    var unique2: NSArray = []
    var satColleges = [String]()
    var gpaColleges = [String]()
    
    
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //Taplytics.registerPushNotifications()
        //UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        if currentReachabilityStatus == .notReachable {
            SVProgressHUD.show(withStatus: "Not Connected to Internet")
            
        } else if currentReachabilityStatus == .reachableViaWiFi{
            SVProgressHUD.dismiss()
        } else if currentReachabilityStatus == .reachableViaWWAN{
            SVProgressHUD.dismiss()
        } else {
            print("Error")
        }
        
        emailTextFeild.delegate = self
        emailTextFeild.tag = 0
        emailTextFeild.returnKeyType = UIReturnKeyType.next
        
        passwordTextFeild.delegate = self
        passwordTextFeild.tag = 1
        passwordTextFeild.returnKeyType = UIReturnKeyType.done
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dataCollect1ViewController:dataCollect1ViewController = storyboard.instantiateViewController(withIdentifier: "dataCollect1ViewController") as! dataCollect1ViewController
        self.present(dataCollect1ViewController, animated: false, completion: nil)
        SVProgressHUD.dismiss()
    }
    @IBAction func loginTapped(_ sender: Any) {
        
        if let email = emailTextFeild.text, let password = passwordTextFeild.text{
            print("Login Tapped")
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        self.createAlert(titleText: "Error", messageText: "Incorrect Email or Password")
                        return
                    }
                    if Auth.auth().currentUser != nil {
                        self.presentFirstController()
                    } else{
                        print("Not Signed In")
                    }
                
                    ////
                    /*
                    self.presentLoggedInScreen()
                    print("success")*/
                    
                })
        }
    }
    
        func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC:HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(HomeVC, animated: true, completion: nil)
    }
    
    func presentFirstController() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let FirstViewVCViewController:FirstViewVCViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewVCViewController") as! FirstViewVCViewController
        self.present(FirstViewVCViewController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            
            nextField.becomeFirstResponder()
            
        } else {
            
            textField.resignFirstResponder()
            
            return true;
            
        }
        
        return false
 }
    func createAlert (titleText : String , messageText: String) {
    
    let alert = UIAlertController (title: titleText, message: messageText, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
    
    }))
    
    self.present(alert, animated: false, completion: nil)
    
    }
    func presentNewHomeVC() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NewHomeVCTabBarController:NewHomeVCTabBarController = storyboard.instantiateViewController(withIdentifier: "NewHomeVCTabBarController") as! NewHomeVCTabBarController
        //NewHomeVCNavigation.collgeMatches = self.unique2
        self.present(NewHomeVCTabBarController, animated: true, completion: nil)
        //if let controller = NewHomeVCTabBarController.viewControllers.first as? NewHomeVCTabBarController {
        //controller.myArray = self.unique2 as NSArray
        myArray = self.unique2
        SVProgressHUD.dismiss()
        
        // }
    }
    func gpaDocumentsCompleted2() {
        print("GPA Documents completed")
        AddArrays2()
        
    }
    
    func satCollegesCompleted2() {
        print("SAT Documents completed")
    }
    
    func AddArrays2() -> Array<Any> {
        let unique = Array(Set(gpaColleges + satColleges))
        self.unique2 = unique as NSArray
        self.presentNewHomeVC()
        return unique
    }
}
