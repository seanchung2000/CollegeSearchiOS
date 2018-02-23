//
//  matching.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/22/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//
import UIKit
import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase
import SVProgressHUD



var satMatching: String = ""
var gpaMatching: String = ""
var actMatching: String = ""
var unique2: NSArray = []
var satColleges = [String]()
var gpaColleges = [String]()

class matching {

}

func findMatchesFunction (gpa: String, sat: String){

    let db = Firestore.firestore()
    let gpaRef = db.collection("Colleges")
    let query1 = gpaRef
        .whereField("Average GPA", isLessThanOrEqualTo : gpa)
        .getDocuments() { (querySnapshot, err) in
            
            // Async call needs completion handler
            defer { gpaDocumentsCompleted() }
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    gpaColleges.append(document.documentID)
                }
            }
    }
    
    let satRef = db.collection("Colleges")
    let query2 = satRef
        .whereField("Average SAT", isLessThanOrEqualTo: sat)
        .getDocuments() { (querySnapshot, err) in
            
            // Async call needs completion handler
            defer { satCollegesCompleted() }
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    satColleges.append(document.documentID)
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
    unique2 = unique as NSArray
   // self.presentNewHomeVC()
    return unique
}

