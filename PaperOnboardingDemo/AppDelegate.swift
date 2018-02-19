//
//  AppDelegate.swift
//  PaperOnboardingDemo
//
//  Created by Alex K. on 25/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit
import Firebase
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    UIApplication.shared.statusBarStyle = .lightContent
    Fabric.with([Crashlytics.self])
    FirebaseApp.configure()
    GADMobileAds.configure(withApplicationID: "ca-app-pub-8784727441633405~1211400707")
    return true
  }
}

