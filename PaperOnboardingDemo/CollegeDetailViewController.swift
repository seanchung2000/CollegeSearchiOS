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

        func getRandomColor() -> UIColor{
            
            var randomRed:CGFloat = CGFloat(drand48())
            
            var randomGreen:CGFloat = CGFloat(drand48())
            
            var randomBlue:CGFloat = CGFloat(drand48())
            
            return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        }
      //  self.view.backgroundColor = getRandomColor()

        
        titleLabel.text = myArray[myIndex] as? String
        
        averageGpa.text = "Average GPA:"
        averageSat.text = "Average SAT Score:"
        averaeAct.text = "Average ACT Score"
        
        let db = Firestore.firestore()
        
        let gpaRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("GPA")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.averageGpa.text = "Average GPA: \(document.documentID)"
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
                    self.averageSat.text = "Average SAT: \(document.documentID)"
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
                self.averaeAct.text = "Average ACT: \(document.documentID)"
            }
        }
}

}

}

