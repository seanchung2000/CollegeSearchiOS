//
//  ScoresViewController.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 7/21/17.
//  Copyright © 2017 Kunwar Sahni All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseFirestore
import Foundation
import Crashlytics
import SVProgressHUD
import CoreData

class ScoresViewController: UIViewController, UITextFieldDelegate {
    var satColleges = [String]()
    var gpaColleges = [String]()

    var docRef: DocumentReference!
//    let defaultStore = Firestore.firestore()
    //var gpaRef = CollectionReference.self
    var unique2: NSArray = []

    
    @IBOutlet weak var GpaScore: UITextField!
    
    @IBOutlet weak var SATscore: UITextField!
    
    @IBOutlet weak var ACT_Score: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID: String = (Auth.auth().currentUser?.uid)!
        docRef = Firestore.firestore().document("Users/\(userID)")
        // Do any additional setup after loading the view.
        
        self.GpaScore.delegate = self
        self.SATscore.delegate = self
        self.ACT_Score.delegate = self
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        GpaScore.resignFirstResponder()
        return(true)
    }
    
    @IBAction func SubmitTapped(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Finding Matches")
        Answers.logCustomEvent(withName: "Scores Submitted",
                                       customAttributes: [:])
        print("Submit Tapped")
        let Sattext = SATscore.text
        let Acttext = ACT_Score.text
        let Gpatext = GpaScore.text
        let gpaScore = Gpatext
        let SatScore2 = Sattext
        let Acttext2 = Acttext
        let CombinedScores = Sattext! + Acttext!
        if GpaScore.text == "" {
            SVProgressHUD.dismiss()
            self.createAlert(titleText: "Error", messageText: "No Weighted GPA Entered")
        }
        else if CombinedScores == "" {
            SVProgressHUD.dismiss()
            self.createAlert(titleText: "Error", messageText: "No SAT nor ACT Score Entered")
        }
        else{
            let userID: String = (Auth.auth().currentUser?.uid)!
            let db = Firestore.firestore()                                                                                                                                                                                            
            db.collection("Users").document("\(userID)").collection("GPA").document("\(gpaScore!)").setData([
                "GPA": "\(gpaScore!)"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            db.collection("Users").document("\(userID)").collection("SAT").document("\(SatScore2!)").setData([
                "SAT": "\(SatScore2!)"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
           /* db.collection("Users").document("\(userID)").collection("ACT").document("\(Acttext2!)").setData([
                "ACT": "\(Acttext2!)"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }*/
            
            
            let dataToSave: [String: Any] = ["GPA": gpaScore!, "SAT Score": SatScore2!, "ACT Score": Acttext2!]
            docRef.setData(dataToSave) { (error) in
                if let error = error {
                    print("error in sending data to fireStore: \(error.localizedDescription)")
                }else {
                    print("Data was succesfully saved to FireStore")
                    self.sendToFireStore(gpa: gpaScore!, sat: SatScore2!)
                }
            }
            
        }
        

    }
    
    func createAlert (titleText : String , messageText: String) {
        
        let alert = UIAlertController (title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    func presentNewHomeVC() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NewHomeVCTabBarController:NewHomeVCTabBarController = storyboard.instantiateViewController(withIdentifier: "NewHomeVCTabBarController") as! NewHomeVCTabBarController
        //NewHomeVCNavigation.collgeMatches = self.unique2
        self.present(NewHomeVCTabBarController, animated: true, completion: nil)
        //if let controller = NewHomeVCTabBarController.viewControllers.first as? NewHomeVCTabBarController {
            //controller.myArray = self.unique2 as NSArray
            myArray = self.unique2

       // }
    }
    

    
// Database setup code
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
            .whereField("Average SAT", isLessThanOrEqualTo: sat)
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
    
    func AddArrays() -> Array<Any> {
        let unique = Array(Set(gpaColleges + satColleges))
        self.unique2 = unique as NSArray
        self.presentNewHomeVC()
        return unique
    }

    
}
