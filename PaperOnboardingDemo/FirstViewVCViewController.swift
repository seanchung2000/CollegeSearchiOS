//
//  FirstViewVCViewController.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 12/30/17.
//  Copyright © 2017 Alex K. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirstViewVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    
      override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            showHomePage()
        }
    }
    
    func showHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC:HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(HomeVC, animated: false, completion: nil)
    }
    

}
