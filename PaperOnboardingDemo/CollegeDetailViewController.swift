//
//  CollegeDetailViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 1/16/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseFirestore


class CollegeDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var averageGpa: UILabel!
    
    @IBOutlet weak var averageSat: UILabel!
    
    @IBOutlet weak var averaeAct: UILabel!
    
    var docRef: DocumentReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = myArray[myIndex] as? String
        
        let db = Firestore.firestore()
        
        let docRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("CollegeData").document("Average GPA")
        docRef.getDocument { (document, error) in
            if let document = document {
                print("Document data: \(document.data())")
                //document.data = self.averageGpa.text
            } else {
                print("Document does not exist")
            }
        }

    }


}
