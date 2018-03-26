//
//  financialSegmentedViewController.swift
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

class financialSegmentedViewController: UIViewController {
    @IBOutlet weak var financialLabel: UILabel!
    @IBOutlet weak var tuitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        let financialRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("Financial")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    
                } else {
                    for document in querySnapshot!.documents {
                        self.financialLabel.text = "Average Financial Aid: $\(document.documentID)"
                    }
                }
        }
        
        let tuitionRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("Tuition")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.tuitionLabel.text = "Average Tuition: $\(document.documentID)"
                    }
                }
        }
    }
}
