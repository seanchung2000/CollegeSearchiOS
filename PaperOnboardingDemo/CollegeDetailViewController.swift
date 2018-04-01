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
import GoogleMobileAds
import SVProgressHUD
import UIKit
//Ads Work
var favoritesArray: [NSArray] = []

class CollegeDetailViewController: UIViewController, GADBannerViewDelegate{
    @IBOutlet weak var collegeImage: UIImageView!
    @IBOutlet weak var controller: UISegmentedControl!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var financialDataView: UIView!
    @IBOutlet weak var academicDataView: UIView!
    @IBOutlet weak var collegeLogo: UIImageView!
    // @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collegeDescription: UITextView!
    @IBOutlet weak var favoriteBarItem: UIBarButtonItem!
    @IBOutlet weak var averageGpa: UILabel!
    @IBOutlet weak var averageSat: UILabel!
    @IBOutlet weak var myBanner: GADBannerView!
    @IBOutlet weak var averageAct: UILabel!
    @IBOutlet weak var averageTuituon: UILabel!
    @IBOutlet weak var averageFinancialAid: UILabel!
    @IBOutlet weak var acceptanceRateGraph: KDCircularProgress!
    @IBOutlet weak var acceptanceRateLabel: UILabel!
    var docRef: DocumentReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        if bookmarkArray.contains(myArray[myIndex] as! String){
            favoriteBarItem.image = #imageLiteral(resourceName: "unCheckedBookmark")

        } else {
            favoriteBarItem.image = #imageLiteral(resourceName: "bookmark-7")
        }
        financialDataView.isHidden = true
        if currentReachabilityStatus == .notReachable {
            SVProgressHUD.show(withStatus: "Not Connected to Internet")
            
        } else if currentReachabilityStatus == .reachableViaWiFi{
            SVProgressHUD.dismiss()
        } else if currentReachabilityStatus == .reachableViaWWAN{
            SVProgressHUD.dismiss()
        } else {
            print("Error")
        }
  //      titleLabel.text = myArrayShuff[myIndex] as? String
    //    averageGpa.text = "Average GPA:"
      //  averageSat.text = "Average SAT Score:"
        //averageAct.text = "Average ACT Score:"
        let userID: String = (Auth.auth().currentUser?.uid)!
        let db = Firestore.firestore()



        
        let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        myBanner.adUnitID = "ca-app-pub-8784727441633405/5374362219"
        myBanner.rootViewController = self
        myBanner.delegate = self
        
        myBanner.load(request)
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
                    if #available(iOS 11.0, *) {
                        self?.navigationController?.navigationBar.prefersLargeTitles = true
                        //navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "Color2")!)
                        self?.navigationController?.navigationBar.topItem?.title = "\(myArray[myIndex])"
                        //navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                        self?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                        
                    } else {
                        self?.navigationController?.navigationBar.topItem?.title = "\(myArray[myIndex])"
                        //navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "Color2")!)
                        self?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                        
                        // UINavigationBar.appearance().barTintColor = UIColor(patternImage: UIImage(named: "Color")!)
                    }
                }
                
            }).resume()
            
        })
///
        
        let imageName2 = "\(myArray[myIndex])CollegeLogo.png"
        let imageURL2 = Storage.storage().reference(forURL: "gs://college-search-2.appspot.com").child(imageName2)
        
        imageURL2.downloadURL(completion: { (url, error) in
            
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
                    self?.collegeLogo.image = imageData
                }
                
            }).resume()
            
        })

    }
  
    func getCollegeData() {
        let db = Firestore.firestore()
        let locationRef = db
            .collection("Colleges").document("\(myArray[myIndex] as! String)")
            .collection("Location")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.locationLabel.text = "\(document.documentID)"
                        print("\(document.documentID)")
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
    
    @IBAction func favoriteTapped(_ sender: Any) {
        //favoritesArray.append(myArray[myIndex] as! NSArray)
        if bookmarkArray.contains(myArray[myIndex] as! String){
            favoriteBarItem.image = #imageLiteral(resourceName: "bookmark-7")
            if let index = bookmarkArray.index(of: myArray[myIndex] as! String) {
                bookmarkArray.remove(at: index)
            }
            print(bookmarkArray)
        } else {
            favoriteBarItem.image = #imageLiteral(resourceName: "unCheckedBookmark")
            bookmarkArray.append(myArray[myIndex] as! String)
            print(bookmarkArray)
        }
    }
    @IBAction func planAVisit(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://bigfuture.collegeboard.org/find-colleges/campus-visit-guide")! as URL, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func apply(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://www.commonapp.org/")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func changeView(_ sender: Any) {
        if controller.selectedSegmentIndex == 0 {
            financialDataView.isHidden = true
            academicDataView.isHidden = false
        }
        if controller.selectedSegmentIndex == 1 {
            academicDataView.isHidden = true
            financialDataView.isHidden = false
        }
    }
    
}
