//
//  academicSegmentedViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 3/25/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseFirestore
import FirebaseStorage
import GoogleMobileAds
import SVProgressHUD

class academicSegmentedViewController: UIViewController {

    @IBOutlet weak var collegeDescription: UITextView!
    @IBOutlet weak var averageGpa: UILabel!
    @IBOutlet weak var averageSat: UILabel!
    @IBOutlet weak var averageAct: UILabel!
    @IBOutlet weak var acceptanceRateGraph: KDCircularProgress!
    @IBOutlet weak var acceptanceRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCollegeData()
    }
    func getCollegeData() {
        if incomingFromBookmarks {
            
            
            let db = Firestore.firestore()
            let gpaRef = db
                .collection("Colleges").document("\(myArrayShuffBookmarks[myIndex] as! String)")
                .collection("GPA")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            self.averageGpa.text = "\(document.documentID)"
                        }
                    }
            }
            
            
            let satRef = db
                .collection("Colleges").document("\(myArrayShuffBookmarks[myIndex] as! String)")
                .collection("SAT")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            self.averageSat.text = "\(document.documentID)"
                        }
                    }
            }
            
            
            
            let actRef = db
                .collection("Colleges").document("\(myArrayShuffBookmarks[myIndex] as! String)")
                .collection("ACT")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            self.averageAct.text = "\(document.documentID)"
                        }
                    }
            }
            
            let descriptionRef = db
                .collection("Colleges").document("\(myArrayShuffBookmarks[myIndex] as! String)")
                .collection("Description")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            self.collegeDescription.text = "\(document.documentID)"
                        }
                    }
            }
            let rateRef = db
                .collection("Colleges").document("\(myArrayShuffBookmarks[myIndex] as! String)")
                .collection("Rate")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            self.acceptanceRateLabel.text = "\(document.documentID)%"
                            //  var ratedouble: Double = document.documentID as! Double
                            //  print(ratedouble)
                            if let rate = Double(document.documentID) {
                                print(rate)
                                var degreeRate: Double = (360 * rate)/100
                                self.acceptanceRateGraph.animate(fromAngle: 0, toAngle: degreeRate, duration: 2.5, completion: nil)
                            }
                        }
                    }
            }
            
            
            
            
            
        } else {
        let db = Firestore.firestore()
        let gpaRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("GPA")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.averageGpa.text = "\(document.documentID)"
                    }
                }
        }
        
        
        let satRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("SAT")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.averageSat.text = "\(document.documentID)"
                    }
                }
        }
        
        
        
        let actRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("ACT")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.averageAct.text = "\(document.documentID)"
                    }
                }
        }
        
        let descriptionRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("Description")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.collegeDescription.text = "\(document.documentID)"
                    }
                }
        }
        let rateRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("Rate")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.acceptanceRateLabel.text = "\(document.documentID)%"
                        //  var ratedouble: Double = document.documentID as! Double
                        //  print(ratedouble)
                        if let rate = Double(document.documentID) {
                            print(rate)
                            var degreeRate: Double = (360 * rate)/100
                            self.acceptanceRateGraph.animate(fromAngle: 0, toAngle: degreeRate, duration: 2.5, completion: nil)
                        }
                    }
                }
        }
        }
    }
}
