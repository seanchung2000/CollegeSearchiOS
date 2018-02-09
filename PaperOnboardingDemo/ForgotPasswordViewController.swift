//
//  ForgotPasswordViewController.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 6/29/17.
//  Copyright © 2017 Alex K. All rights reserved.
//

import UIKit
import FirebaseAuth

// this is from a phone

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextFeild: UITextField!

    @IBAction func resetPasswordTapped(_ sender: Any) {
        
        if let email = emailTextFeild.text{
            
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                return
            }
            self.presentLoggedInScreen()
            print("success")

          
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextFeild.delegate = self
        
        emailTextFeild.tag = 0
        
        emailTextFeild.returnKeyType = UIReturnKeyType.done
        
            }
    
    func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginPageController:loginPageController = storyboard.instantiateViewController(withIdentifier: "loginPageController") as! loginPageController
        self.present(loginPageController, animated: true, completion: nil)
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

    
}
