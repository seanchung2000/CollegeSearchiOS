//
//  SignUpViewController.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 6/29/17.
//  Copyright © 2017 Alex K. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    @IBOutlet weak var emailTextFeild: UITextField!
    
    @IBOutlet weak var nameTextFeild: UITextField!
    
    @IBOutlet weak var confirmPasswordTextFeild: UITextField!
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if let email = emailTextFeild.text, let password = passwordTextFeild.text{
            
            if passwordTextFeild.text == confirmPasswordTextFeild.text{
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                self.presentLoggedInScreen()
                print("success")
            })
        }
            else {
                print("passwords do not match")
                self.createAlert(titleText: "Error", messageText: "Passwords do not match.")
                
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
=======
        
>>>>>>> master
        nameTextFeild.delegate = self
        nameTextFeild .tag = 0
        nameTextFeild.returnKeyType = UIReturnKeyType.next
<<<<<<< HEAD
    
        emailTextFeild.delegate = self
        
        emailTextFeild.tag = 1
        
=======
        
        emailTextFeild.delegate = self
        emailTextFeild.tag = 1
>>>>>>> master
        emailTextFeild.returnKeyType = UIReturnKeyType.next
        
        passwordTextFeild.delegate = self
        passwordTextFeild.tag = 2
        passwordTextFeild.returnKeyType = UIReturnKeyType.next
        
<<<<<<< HEAD
        passwordTextFeild.tag = 2
        
        passwordTextFeild.returnKeyType = UIReturnKeyType.next
        
        confirmPasswordTextFeild.delegate = self
        
        confirmPasswordTextFeild.returnKeyType = UIReturnKeyType.done
        
        confirmPasswordTextFeild.tag = 3
=======
>>>>>>> master
        
        confirmPasswordTextFeild.delegate = self
        confirmPasswordTextFeild.tag = 3
        confirmPasswordTextFeild.returnKeyType = UIReturnKeyType.done
        
        // Do any additional setup after loading the view.
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
    
    func createAlert (titleText : String , messageText: String) {
        
        let alert = UIAlertController (title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }



}
