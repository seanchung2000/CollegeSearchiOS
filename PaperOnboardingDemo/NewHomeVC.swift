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
import SVProgressHUD
var myArray: NSArray = ["2"]
var array2 =  [AnyObject]()
var myIndex: Int = 0
let myArrayShuff = myArray.shuffled()
var locationArray: NSArray = ["1"]
var bookmarkArray: Array = [""]

class CollegeTableViewCell: UITableViewCell {
    
    static let identifier = "CollegeTableViewCell"

    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var collegeCampusImage: UIImageView!
    
    weak var dataTask: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel()
        imageView?.image = nil
        collegeCampusImage?.image = nil
    }
    
}
extension NewHomeVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        
    }
}

class NewHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var imageCache = [String:UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = bookmarkArray.index(of: "") {
            bookmarkArray.remove(at: index)
        }
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "Color2")!)
            navigationController?.navigationBar.topItem?.title = "Your Colleges"
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        } else {
            navigationController?.navigationBar.topItem?.title = "Your Colleges"
            navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "Color2")!)
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

           // UINavigationBar.appearance().barTintColor = UIColor(patternImage: UIImage(named: "Color")!)
        }
        
        
        if currentReachabilityStatus == .notReachable {
            SVProgressHUD.show(withStatus: "Not Connected to Internet")
            
        } else if currentReachabilityStatus == .reachableViaWiFi{
            SVProgressHUD.dismiss()
        } else if currentReachabilityStatus == .reachableViaWWAN{
            SVProgressHUD.dismiss()
        } else {
            print("Error")
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        print("Number of Schools = \(myArray.count)")

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
    
    
    @IBAction func feedbackTapped(_ sender: Any) {
        Answers.logCustomEvent(withName: "Feedback Pressed",
                               customAttributes: [:])
        UIApplication.shared.open(URL(string: "https://interadaptive.com/feedback")! as URL, options: [:], completionHandler: nil)
    }
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bookmark = bookmarkAction(at: indexPath)
        return UISwipeActionsConfiguration(actions:[bookmark])
    }
    
    @available(iOS 11.0, *)
    func bookmarkAction(at: IndexPath) -> UIContextualAction {
       // let college = myArrayShuff[indexPath.row]
        var actionTitle: String = ""
        if bookmarkArray.contains(myArray[myIndex] as! String){
            actionTitle = "Remove Bookmark"
        } else {
            actionTitle = "Bookmark"
        }
        let action = UIContextualAction(style: .normal, title: actionTitle) { (action, view, completion) in
            
            if bookmarkArray.contains(myArray[myIndex] as! String){
                if let index = bookmarkArray.index(of: myArray[myIndex] as! String) {
                    bookmarkArray.remove(at: index)
                }
                print(bookmarkArray)
            } else {
                bookmarkArray.append(myArray[myIndex] as! String)
                print(bookmarkArray)
            }
            
            
           completion(true)
        }
        action.backgroundColor = UIColor(patternImage: UIImage(named: "Color2")!)
        if bookmarkArray.contains(myArray[myIndex] as! String){
            action.image = #imageLiteral(resourceName: "unCheckedBookmark")
        } else {
            action.image = #imageLiteral(resourceName: "bookmark-7")
        }
        return action
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
            

        let schoolKey = "\(myArray[indexPath.row])"
            cell.collegeName.text = schoolKey
       //     cell.collegeLocation.text = "\(locationArray[indexPath.row])"
            
       // cell.textLabel?.font = UIFont(name:"Eveleth", size:20)
        //cell.textLabel?.textColor = UIColor.white
        //cell.backgroundColor = getRandomColor()
            
            

            let clearView = UIView()
            clearView.backgroundColor = UIColor.clear // Whatever color you like
            UITableViewCell.appearance().selectedBackgroundView = clearView
        

            if let image = imageCache[schoolKey] {
                cell.collegeCampusImage?.image = image
            } else {
                let imageName = "\(myArray[indexPath.row])2.png"
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
                            cell.collegeCampusImage.layer.cornerRadius = 10
                            cell.collegeCampusImage.clipsToBounds = true
                            cell.collegeCampusImage.image = imageData
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





