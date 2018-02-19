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

class loginPageController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextFeild.delegate = self
        
        emailTextFeild.tag = 0
        
        emailTextFeild.returnKeyType = UIReturnKeyType.next
        
        passwordTextFeild.delegate = self
        
        passwordTextFeild.tag = 1
        
        
        passwordTextFeild.returnKeyType = UIReturnKeyType.done
        
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
                    self.presentLoggedInScreen()
                    print("success")
                    Answers.logSignUp(withMethod: "Manual",
                                                success: true,
                                                customAttributes: [:])
                    
                })
        }
    }
    
        func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC:HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(HomeVC, animated: true, completion: nil)
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
}
