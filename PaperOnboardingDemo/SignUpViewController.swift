//
//  SignUpViewController.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 6/29/17.
//  Copyright © 2017 Kunwar Sahni All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
import Fabric
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    @IBOutlet weak var emailTextFeild: UITextField!
    
    @IBOutlet weak var nameTextFeild: UITextField!
    
    @IBOutlet weak var confirmPasswordTextFeild: UITextField!
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Signing You Up")
        
        if let email = emailTextFeild.text, let password = passwordTextFeild.text{
            
            if passwordTextFeild.text == confirmPasswordTextFeild.text{
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                
                if let firebaseError = error {
                    SVProgressHUD.dismiss()
                    print(firebaseError.localizedDescription)
                     self.createAlert(titleText: "Error", messageText: "\(firebaseError.localizedDescription)")
                    return
                }
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        self.createAlert(titleText: "Error", messageText: "Incorrect Email or Password")
                        return
                    }
                    Answers.logSignUp(withMethod: "Manual",
                                      success: true,
                                      customAttributes: [:])
                    
                })
                //
                let userID: String = (Auth.auth().currentUser?.uid)!
                let db = Firestore.firestore()
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
                //
                print("success")
                self.presentLoggedInScreen()
            })
        }
            else {
                SVProgressHUD.dismiss()
                print("passwords do not match")
                self.createAlert(titleText: "Error", messageText: "Passwords do not match.")
                
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextFeild.delegate = self
        nameTextFeild .tag = 0
        nameTextFeild.returnKeyType = UIReturnKeyType.next
        
        emailTextFeild.delegate = self
        emailTextFeild.tag = 1
        emailTextFeild.returnKeyType = UIReturnKeyType.next
        
        passwordTextFeild.delegate = self
        passwordTextFeild.tag = 2
        passwordTextFeild.returnKeyType = UIReturnKeyType.next
        
        
        confirmPasswordTextFeild.delegate = self
        confirmPasswordTextFeild.tag = 3
        confirmPasswordTextFeild.returnKeyType = UIReturnKeyType.done
        
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dataCollect1ViewController:dataCollect1ViewController = storyboard.instantiateViewController(withIdentifier: "dataCollect1ViewController") as! dataCollect1ViewController
        self.present(dataCollect1ViewController, animated: true, completion: nil)
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
