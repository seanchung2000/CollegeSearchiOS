//
//  AppDelegate.swift
//  PaperOnboardingDemo
//
//  Created by Alex K. on 25/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
//import FBSDKCoreKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    //icons8-back-100

    
    // Override point for customization after application launch.
    UIApplication.shared.statusBarStyle = .lightContent
    Fabric.with([Crashlytics.self])
    FirebaseApp.configure()
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
//FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    return true
  }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        //    let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
            
            GIDSignIn.sharedInstance().handle(url,
                                              sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!,
                                              annotation: options[UIApplicationOpenURLOptionsKey.annotation])
            //return handled
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to log into Google", err)
            return
        }
        print("Succesfully logged into Google")
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials, completion:{ (user, error) in
            if let err = error {
                print("Failed to create a Firebase User with Google Account", err)
            }
            
            guard let uid = user?.uid else { return }
            print("Succesfully logged into Firebase with Google", uid)
            self.showHomePage()
        })
    }
    
    func showHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window!.rootViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC")
    }
}

