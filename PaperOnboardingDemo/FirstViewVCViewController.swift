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
import Taplytics

var sat: String = ""
var gpa: String = ""
var act: String = ""

class FirstViewVCViewController: UIViewController {
    var unique2: NSArray = []
    var satColleges = [String]()
    var gpaColleges = [String]()
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /////////
        //3.14 1390
        
        
        /////////
        SVProgressHUD.show(withStatus: "Loading Your Data")
        starting()
        
    }
    
    func showHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dataCollect1ViewController:dataCollect1ViewController = storyboard.instantiateViewController(withIdentifier: "dataCollect1ViewController") as! dataCollect1ViewController
        self.present(dataCollect1ViewController, animated: false, completion: nil)
        SVProgressHUD.dismiss()
    }

        func starting() {
        SVProgressHUD.show(withStatus: "Loading Your Data")
        let db = Firestore.firestore()
        if Auth.auth().currentUser != nil {
        nextButton.isEnabled = false
        SVProgressHUD.show(withStatus: "Loading Your Data")
        let userID: String = (Auth.auth().currentUser?.uid)!
            
            let bookmarkRef = db
                .collection("Users").document("\(userID)")
                .collection("Bookmarks")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            if document.exists {
                                bookmarkArray.append(document.documentID)
                               // print("BOOKMARKS: \(bookmarkArray)")
                            } else {
                                //
                            }
                        }
                    }
            }
            
            
            
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
                        } else{
                            //
                            var userSatScoreString = document.documentID
                             userSatScoreString = userSatScoreString.replacingOccurrences(of: "Optional(\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                            userSatScoreString = userSatScoreString.replacingOccurrences(of: "\")", with: "", options: NSString.CompareOptions.literal, range: nil)
                            var userSatScore = Int(userSatScoreString)
                            print(userSatScore)
                            //
                            //
                            
                            let satRef1 = db
                                .collection("Colleges")
                                .getDocuments() { (querySnapshot, err) in
                                    if let err = err {
                                        print("Error getting documents: \(err)")
                                    } else {
                                        for document in querySnapshot!.documents {
                                            var collegeName = document.documentID
                                            
                                            ///
                                            
                                            
                                            let satRef2 = db
                                                .collection("Colleges").document("\(document.documentID)")
                                                .collection("SAT")
                                                .getDocuments() { (querySnapshot, err) in
                                                    
                                                    
                                                    if let err = err {
                                                        print("Error getting documents: \(err)")
                                                    } else {
                                                        for document in querySnapshot!.documents {
                                                            
                                                            var collegeSatScoreString = document.documentID
                                                            
                                                            collegeSatScoreString = collegeSatScoreString.replacingOccurrences(of: "Optional(\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                            collegeSatScoreString = collegeSatScoreString.replacingOccurrences(of: "\")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                            
                                                            var collegeSatScore = Int(collegeSatScoreString)
                                                            
                                                            if collegeSatScoreString == "Not Available" {
                                                                print("Sat Score Is Not Avaliable")
                                                            } else if collegeSatScore == nil {
                                                                
                                                            } else if userSatScore == nil {
                                                            
                                                            } else if collegeSatScore! < userSatScore! {
                                                                var superScore = userSatScore! - 130
                                                                print(userSatScore)
                                                                print(superScore)
                                                                if collegeSatScore! >= superScore {
                                                                    self.satColleges.append(collegeName)
                                                                }
                                                            } else {
                                                            }
                                                            
                                                        }
                                                        defer { self.satCollegesCompleted2() }

                                                    }
                                            }

                                            
                                            ///
                                        }
                                    }
                            }
                            
                            
                            //
                    }
                    }
                    }
                }

            
            
            ////GPA GPA GPA GPA GPA
            
            
            let gpaReg = db
                .collection("Users").document("\(userID)")
                .collection("GPA")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            if (document.documentID == "0"){
                                self.showHomePage()
                            } else{
                                //
                                var userGpaString = document.documentID
                                userGpaString = userGpaString.replacingOccurrences(of: "Optional(\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                                userGpaString = userGpaString.replacingOccurrences(of: "\")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                var userGpaScore = Double(userGpaString)
                                print(userGpaScore)
                                //
                                //
                                
                                let satRef1 = db
                                    .collection("Colleges")
                                    .getDocuments() { (querySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                        } else {
                                            for document in querySnapshot!.documents {
                                                var collegeName = document.documentID
                                                
                                                ///
                                                
                                                
                                                let satRef2 = db
                                                    .collection("Colleges").document("\(document.documentID)")
                                                    .collection("GPA")
                                                    .getDocuments() { (querySnapshot, err) in
                                                        
                                                        
                                                        if let err = err {
                                                            print("Error getting documents: \(err)")
                                                        } else {
                                                            for document in querySnapshot!.documents {
                                                                
                                                                var collegeGpaString = document.documentID
                                                                
                                                                collegeGpaString = collegeGpaString.replacingOccurrences(of: "Optional(\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                                collegeGpaString = collegeGpaString.replacingOccurrences(of: "\")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                                
                                                                var collegeGpa = Double(collegeGpaString)
                                                                
                                                                if collegeGpaString == "Not Available" {
                                                                    print("Sat Score Is Not Avaliable")
                                                                } else if collegeGpa == nil {
                                                                    
                                                                } else if userGpaScore == nil {
                                                                    
                                                                } else if collegeGpa! < userGpaScore! {
                                                                    var gpaSuperScore = userGpaScore! - 1
                                                                    if collegeGpa! >= userGpaScore!{
                                                                        self.gpaColleges.append(collegeName)
                                                                    }
                                                                } else {
                                                                }
                                                                
                                                            }
                                                            defer { self.gpaDocumentsCompleted2() }

                                                        }
                                                }
                                                
                                                
                                                ///
                                            }
                                        }
                                }
                                
                                
                                //
                            }
                        }
                    }
            }

            
            
            
            
            
            
            
            
            //findMatchesFunction(gpa: gpa, sat: sat)
          //  showHomePage()
        }else{
            nextButton.isEnabled = true
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
       // SVProgressHUD.dismiss()

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
