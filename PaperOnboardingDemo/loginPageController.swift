//
//  loginPageController.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 6/28/17.
//  Copyright © 2017 Alex K. All rights reserved.
//

import UIKit
//import FBSDKLoginKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class loginPageController: UIViewController, GIDSignInUIDelegate, UITextFieldDelegate {


    
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
        
        

       //setupFacebookButtons()
        
        //google Login Button
        //let googleButton = GIDSignInButton()
        //googleButton.frame = CGRect(x: 199, y: 520, width: view.frame.width - 55, height: 43)
        //view.addSubview(googleButton)
        
        let customButton = UIButton(type: .system)
        customButton.frame = CGRect(x: 200, y: 520, width: 55, height: 55)
        customButton.backgroundColor = .clear
        customButton.addTarget(self, action: #selector(handleCustomGoogleSign), for: .touchUpInside)
        customButton.setTitleColor(.white, for: .normal)
        customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(customButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
   /* fileprivate func setupFacebookButtons() {
      let loginButton = FBSDKLoginButton()
       // view.addSubview(loginButton)
        //frame's are obselete, please use constraints instead because its 2016 after all
        loginButton.frame = CGRect(x: 130, y: 518, width: 45, height: 47)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
        //add our custom fb login button here
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = .clear
        customFBButton.frame = CGRect(x: 130, y: 518, width: 45, height: 47)
        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFBButton.setTitleColor(.white, for: .normal)
        view.addSubview(customFBButton)
        
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    }*/
    
   /* @objc func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:", err)
                self.createAlert(titleText: "Error", messageText: "Facbook Login is not working right now, check your device's network connection and try again later.")
                return
            }
            
            self.showEmailAddress()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        showEmailAddress()
    }
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }
            self.presentLoggedInScreen()
            print("Successfully logged in with our user: ", user ?? "")
        })
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            
            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
        }
    }*/
    
    @objc func handleCustomGoogleSign() {
        GIDSignIn.sharedInstance().signIn()
        print("google button tapped")
    }
    
  /*  override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.presentLoggedInScreen()
        }
    }*/

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







