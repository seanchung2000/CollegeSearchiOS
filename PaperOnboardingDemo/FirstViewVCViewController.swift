//
//  FirstViewVCViewController.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 12/30/17.
//  Copyright © 2017 Alex K. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase

var sat: String = ""
var gpa: String = ""
var act: String = ""

class FirstViewVCViewController: UIViewController {
    var unique2: NSArray = []
    var satColleges = [String]()
    var gpaColleges = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC:HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(HomeVC, animated: false, completion: nil) 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let db = Firestore.firestore()
        if Auth.auth().currentUser != nil {
        /*let userID: String = (Auth.auth().currentUser?.uid)!
        let satRef = db
            .collection("Users").document("\(userID)")
            .collection("SAT")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        sat = document.documentID
                        print(sat)
                        print(document.documentID)
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
                        gpa = document.documentID
                        print(gpa)
                        print(document.documentID)
                    }
                }
        }
        sendToFireStore(gpa: gpa, sat: sat)*/
            showHomePage()
        }else{
            print("Not Signed In")
        }
    }
    func sendToFireStore(gpa: String, sat: String) {
        
        let db = Firestore.firestore()
        let gpaRef = db.collection("Colleges")
        let query1 = gpaRef
            .whereField("Average GPA", isLessThanOrEqualTo : gpa)
            .getDocuments() { (querySnapshot, err) in
                
                // Async call needs completion handler
                defer { self.gpaDocumentsCompleted() }
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.gpaColleges.append(document.documentID)
                    }
                }
        }
        
        let satRef = db.collection("Colleges")
        let query2 = satRef
            .whereField("Average SAT Score", isLessThanOrEqualTo: sat)
            .getDocuments() { (querySnapshot, err) in
                
                // Async call needs completion handler
                defer { self.satCollegesCompleted() }
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.satColleges.append(document.documentID)
                    }
                }
                
        }
    }
    func gpaDocumentsCompleted() {
        print("GPA Documents completed")
        AddArrays()
        
    }
    
    func satCollegesCompleted() {
        print("SAT Documents completed")
    }
    func presentNewHomeVC() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NewHomeVCTabBarController:NewHomeVCTabBarController = storyboard.instantiateViewController(withIdentifier: "NewHomeVCTabBarController") as! NewHomeVCTabBarController
        self.present(NewHomeVCTabBarController, animated: true, completion: nil)
        myArray = self.unique2

    }
    
    func AddArrays() -> Array<Any> {
        let unique = Array(Set(gpaColleges + satColleges))
        self.unique2 = unique as NSArray
        self.presentNewHomeVC()
        return unique
    }
}
