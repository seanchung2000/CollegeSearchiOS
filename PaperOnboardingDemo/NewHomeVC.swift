//
//  NewHomeVC.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 12/23/17.
//  Copyright © 2017 Alex K. All rights reserved.
// TESTING FROM XCODE 2.0

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseStorage

class NewHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var myArray: NSArray = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: SlideMenu!
    
    
    var menuShowing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(myArray)

        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "College"))
       // cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"cell_normal.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.blue
    }
    @IBAction func loggedOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginPageController:loginPageController = storyboard.instantiateViewController(withIdentifier: "loginPageController") as! loginPageController
            self.present(loginPageController, animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func scoresTapped(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ScoresViewController:ScoresViewController = storyboard.instantiateViewController(withIdentifier: "ScoresViewController") as! ScoresViewController
        self.present(ScoresViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    @IBAction func openMenu(_ sender: Any) {
        if(menuShowing) {
            leadingConstraint.constant = -180
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                
            })
            
        } else {
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()

            })
        }
        
        menuShowing = !menuShowing
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "\(myArray[indexPath.row])"
            
            // Get a reference to the storage service using the default Firebase App
            let storage = Storage.storage()
            
            // Create a storage reference from our storage service
            let storageRef = storage.reference()
            
            cell.imageView?.image = UIImage(named: "SU_New_BlockStree_2color")
        return cell
            
    }
    
    
    
    
    
}
 
