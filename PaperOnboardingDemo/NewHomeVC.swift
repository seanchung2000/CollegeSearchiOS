//
//  NewHomeVC.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 12/23/17.
//  Copyright © 2017 Alex K. All rights reserved.
// TESTING FROM XCODE 2.0

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseStorage
//import FirebaseStorageUI
//for sean

var myArray: NSArray = []
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

class NewHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: SlideMenu!
    
    
    var menuShowing = false
    
    var imageCache = [String:UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(myArray)

        

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "College"))
       // cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"cell_normal.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.blue
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
            
        //let cell = UITableViewCell()
            
            
            func hexStringToUIColor (hex:String) -> UIColor {
                var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
                
                if (cString.hasPrefix("#")) {
                    cString.remove(at: cString.startIndex)
                }
                
                if ((cString.count) != 6) {
                    return UIColor.gray
                }
                
                var rgbValue:UInt32 = 0
                Scanner(string: cString).scanHexInt32(&rgbValue)
                
                return UIColor(
                    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                    alpha: CGFloat(1.0)
                )
            }

            
            
        let schoolKey = "\(myArray[indexPath.row])"
        cell.textLabel!.text = schoolKey
        cell.textLabel?.font = UIFont(name:"Eveleth", size:20)
        cell.textLabel?.textColor = UIColor.gray
        cell.backgroundColor = UIColor.white
            
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





