//
//  NewHomeVC.swift
//  College Search
//
//  Created by Kunwar Sahni on 12/23/17.
//  Copyright © 2017 Kunwar Sahni All rights reserved.

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseStorage

var myArray: NSArray = ["2"]
var array2 =  [AnyObject]()
var myIndex: Int = 0


class CollegeTableViewCell: UITableViewCell {
    
    static let identifier = "CollegeTableViewCell"

    
    weak var dataTask: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel()
        imageView?.image = nil
    }
    
}

class NewHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GADNativeAppInstallAdLoaderDelegate, GADNativeContentAdLoaderDelegate {
    /// The ad unit ID from the AdMob UI.
    let adUnitID = "ca-app-pub-8784727441633405/5374362219"
    
    /// The number of native ads to load.
    let numAdsToLoad = 5
    
    /// The native ads.
    var nativeAds = [GADNativeAd]()
    
    /// The ad loader that loads the native ads.
    var adLoader: GADAdLoader!
    
    /// The number of completed ad loads (success or failures).
    var numAdLoadCallbacks = 0
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: SlideMenu!
    
    
    var menuShowing = false
    
    var imageCache = [String:UIImage]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //leadingConstraint.constant = -180
        // Prepare the ad loader and start loading ads.
        adLoader = GADAdLoader(adUnitID: adUnitID,
                               rootViewController: self,
                               adTypes: [GADAdLoaderAdType.nativeAppInstall,
                                         GADAdLoaderAdType.nativeContent],
                               options: nil)
        adLoader.delegate = self
        preloadNextAd()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "College"))
       // cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"cell_normal.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        print("Number of Schools = \(myArray.count)")
        tableView.register(UINib(nibName: "NativeAppInstallAdCell", bundle: nil),
                           forCellReuseIdentifier: "NativeAppInstallAdCell")
        tableView.register(UINib(nibName: "NativeContentAdCell", bundle: nil),
                           forCellReuseIdentifier: "NativeContentAdCell")
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.blue
    }
    
    func preloadNextAd() {
        if numAdLoadCallbacks < numAdsToLoad {
            adLoader.load(GADRequest())
        } else {
            //enableMenuButton()
        }
    }
    func adLoader(_ adLoader: GADAdLoader,
                  didFailToReceiveAdWithError error: GADRequestError) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
        
        // Increment the number of ad load callbacks.
        numAdLoadCallbacks += 1
        
        // Load the next native ad.
        preloadNextAd()
    }
    
    func adLoader(_ adLoader: GADAdLoader,
                  didReceive nativeAppInstallAd: GADNativeAppInstallAd) {
        print("Received native app install ad: \(nativeAppInstallAd)")
        
        // Increment the number of ad load callbacks.
        numAdLoadCallbacks += 1
        
        // Add the native ad to the list of native ads.
        nativeAds.append(nativeAppInstallAd)
        
        // Load the next native ad.
        preloadNextAd()
    }
    
    func adLoader(_ adLoader: GADAdLoader,
                  didReceive nativeContentAd: GADNativeContentAd) {
        print("Received native content ad: \(nativeContentAd)")
        
        // Increment the number of ad load callbacks.
        numAdLoadCallbacks += 1
        
        // Add the native ad to the list of native ads.
        nativeAds.append(nativeContentAd)
        
        // Load the next native ad.
        preloadNextAd()
    }
    
    @IBAction func loggedOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginPageController:loginPageController = storyboard.instantiateViewController(withIdentifier: "loginPageController") as! loginPageController
            self.present(loginPageController, animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func scoresTapped(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ScoresViewController:ScoresViewController = storyboard.instantiateViewController(withIdentifier: "ScoresViewController") as! ScoresViewController
        self.present(ScoresViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func feedbackTapped(_ sender: Any) {
        Answers.logCustomEvent(withName: "Feedback Pressed",
                               customAttributes: [:])
        UIApplication.shared.open(URL(string: "https://interadaptive.com/feedback")! as URL, options: [:], completionHandler: nil)
    }
    
    
    
    @IBAction func openMenu(_ sender: Any) {
        if(menuShowing) {
            leadingConstraint.constant = -180
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                
            })
            
        } else {
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()

            })
        }
        
        menuShowing = !menuShowing
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

                
            var cell: CollegeTableViewCell! = tableView.dequeueReusableCell(withIdentifier: CollegeTableViewCell.identifier) as? CollegeTableViewCell
            if cell == nil {
                 cell =  CollegeTableViewCell(style: .default, reuseIdentifier: CollegeTableViewCell.identifier) as? CollegeTableViewCell
            }
            
            func getRandomColor() -> UIColor{
                
                var randomRed:CGFloat = CGFloat(drand48())
                
                var randomGreen:CGFloat = CGFloat(drand48())
                
                var randomBlue:CGFloat = CGFloat(drand48())
                
                return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}
        let schoolKey = "\(myArray[indexPath.row])"
        cell.textLabel!.text = schoolKey
        cell.textLabel?.font = UIFont(name:"Eveleth", size:20)
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = getRandomColor()

            let clearView = UIView()
            clearView.backgroundColor = UIColor.clear // Whatever color you like
            UITableViewCell.appearance().selectedBackgroundView = clearView
        

            if let image = imageCache[schoolKey] {
                cell.imageView?.image = image
            } else {
                let imageName = "\(myArray[indexPath.row])CollegeLogo.png"
                let imageURL = Storage.storage().reference(forURL: "gs://college-search-2.appspot.com").child(imageName)
                
                imageURL.downloadURL(completion: { (url, error) in
                    
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    cell.dataTask = URLSession.shared.dataTask(with: url!, completionHandler: { [weak self] (data, response, error) in
                        guard let strongSelf = self else { return }
                        if error != nil {
                            print(error)
                            return
                        }
                        
                        guard let imageData = UIImage(data: data!) else { return }
                        
                        DispatchQueue.main.async {
                            cell.imageView?.image = imageData
                            cell.setNeedsLayout()
                            strongSelf.imageCache[schoolKey] = imageData
                        }
                        
                    })
                    cell.dataTask?.resume()
                    
                })
            }
            


            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
}





