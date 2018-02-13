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
import FirebaseStorage



class CollegeDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collegeImage: UIImageView!
    @IBOutlet weak var collegeDescription: UITextView!
    @IBOutlet weak var averageGpa: UILabel!
    @IBOutlet weak var averageSat: UILabel!
    @IBOutlet weak var averageAct: UILabel!
    @IBOutlet weak var averageTuituon: UILabel!
    @IBOutlet weak var averageFinancialAid: UILabel!
    @IBOutlet weak var acceptanceRateGraph: KDCircularProgress!
    @IBOutlet weak var acceptanceRateLabel: UILabel!
    var docRef: DocumentReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = myArray[myIndex] as? String
        averageGpa.text = "Average GPA:"
        averageSat.text = "Average SAT Score:"
        averageAct.text = "Average ACT Score:"
        //averageTuituon.text = "Average Tuituon:"
        //averageFinancialAid.text = "Average Financial Aid:"
        DispatchQueue.main.async {
            self.getCollegeData()
        }
        let imageName = "\(myArray[myIndex])2.png"
        let imageURL = Storage.storage().reference(forURL: "gs://college-search-2.appspot.com").child(imageName)
        
        imageURL.downloadURL(completion: { (url, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            URLSession.shared.dataTask(with: url!, completionHandler: { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                if error != nil {
                    print(error)
                    return
                }
                
                guard let imageData = UIImage(data: data!) else { return }
                
                DispatchQueue.main.async {
                    self?.collegeImage.image = imageData
                }
                
            }).resume()
            
        })

    }
  
    func getCollegeData() {
        let db = Firestore.firestore()
        let financialRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("Financial")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    print("HELLLLLOOOOO2")

                } else {
                    for document in querySnapshot!.documents {
                        self.averageFinancialAid.text = "Average Financial Aid: $\(document.documentID)"
                        print("HELLLLLOOOOO")
                    }
                }
        }
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
                self.averageAct.text = "Average ACT: \(document.documentID)"
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
        let tuitionRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("Tuition")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.averageTuituon.text = "Average Tuition: $\(document.documentID)"
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

    
    @IBAction func websiteButton(_ sender: Any) {
        let db = Firestore.firestore()
        let websiteRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("Website")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        UIApplication.shared.open(URL(string: "https://\(document.documentID)")! as URL, options: [:], completionHandler: nil)
                    }
                }
        }
    }
    
    @IBAction func planAVisit(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://bigfuture.collegeboard.org/find-colleges/campus-visit-guide")! as URL, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func apply(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://www.commonapp.org/")! as URL, options: [:], completionHandler: nil)
    }
    
}
