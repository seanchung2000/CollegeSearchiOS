//
//  FirstViewVCViewController.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 12/30/17.
//  Copyright © 2017 Kunwar Sahni All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase
import SVProgressHUD

var sat: String = ""
var gpa: String = ""
var act: String = ""

class FirstViewVCViewController: UIViewController {
    var unique2: NSArray = []
    var satColleges = [String]()
    var gpaColleges = [String]()
    
    override func viewDidLoad() {
        if currentReachabilityStatus == .notReachable {
            SVProgressHUD.show(withStatus: "Not Connected to Internet")

        } else if currentReachabilityStatus == .reachableViaWiFi{
            SVProgressHUD.dismiss()
        } else if currentReachabilityStatus == .reachableViaWWAN{
            SVProgressHUD.dismiss()
        } else {
            print("Error")
        }
        super.viewDidLoad()
    }
    
    func showHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dataCollect1ViewController:dataCollect1ViewController = storyboard.instantiateViewController(withIdentifier: "dataCollect1ViewController") as! dataCollect1ViewController
        self.present(dataCollect1ViewController, animated: false, completion: nil)
        SVProgressHUD.dismiss()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let db = Firestore.firestore()
        if Auth.auth().currentUser != nil {
       SVProgressHUD.show(withStatus: "Loading Your Data")
        let userID: String = (Auth.auth().currentUser?.uid)!
        let satRef = db
            .collection("Users").document("\(userID)")
            .collection("SAT")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if (document.documentID == "0"){
                            self.showHomePage()
                        }else{
                        let satRef = db.collection("Colleges")
                        let query2 = satRef
                            .whereField("Average SAT", isLessThanOrEqualTo: document.documentID)
                            .getDocuments() { (querySnapshot, err) in
                                
                                // Async call needs completion handler
                                defer { self.satCollegesCompleted2() }
                                
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else {
                                    for document in querySnapshot!.documents {
                                        self.satColleges.append(document.documentID)
                                    }
                                }
                                
                        }//
                    }
                    }
                    }
                }
        
        let gpaRef = db
            .collection("Users").document("\(userID)")
            .collection("GPA")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if(document.documentID == "0"){
                            self.showHomePage()
                        }else {
                        let gpaRef = db.collection("Colleges")
                        let query1 = gpaRef
                            .whereField("Average GPA", isLessThanOrEqualTo : document.documentID)
                            .getDocuments() { (querySnapshot, err) in
                                
                                // Async call needs completion handler
                                defer { self.gpaDocumentsCompleted2() }
                                
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else {
                                    for document in querySnapshot!.documents {
                                        self.satColleges.append(document.documentID)
                                    }
                                }
                        }////
                    }
                    }
                }
        }
            //findMatchesFunction(gpa: gpa, sat: sat)
          //  showHomePage()
        }else{
            print("Not Signed In")
            SVProgressHUD.dismiss()
        }
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
