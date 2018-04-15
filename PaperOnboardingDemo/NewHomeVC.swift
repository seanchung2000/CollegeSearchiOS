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
var filteredmyArray = [String]()
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


class NewHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var oopsLabel: UILabel!
    
    var imageCache = [String:UIImage]()
    var searchController = UISearchController()
    var resultsController = UITableViewController()
    
    


//    func updateSearchResults(for searchController: UISearchController) {
//        // let swiftArray: [String] = objCArray.flatMap({ $0 as? String })
//        let stringArray: [String] = myArray.flatMap({ $0 as? String })
//        print(stringArray)
//        filteredmyArray = stringArray.filter({ (array:String) -> Bool in
//            if stringArray.contains(searchController.searchBar.text!){
//                return true
//            } else {
//                return false
//            }
//        })
//        resultsController.tableView.reloadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        incomingFromBookmarks = false
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

    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
//        let stringArray: [String] = myArray.flatMap({ $0 as? String })
//        print(stringArray)
        
        var objCArray = NSMutableArray(array: myArray)
        if let stringArray = objCArray as NSArray as? [String] {
            filteredmyArray = stringArray.filter({ (array:String) -> Bool in
                return stringArray.contains(searchText)
            })
            tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if myArray.count == 0 {
            oopsLabel.isHidden = false
        } else {
            oopsLabel.isHidden = true
        }
    }

//    @available(iOS 11.0, *)
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let bookmark = bookmarkAction(at: indexPath)
//        return UISwipeActionsConfiguration(actions:[bookmark])
//    }
//
//    @available(iOS 11.0, *)
//    func bookmarkAction(at: IndexPath) -> UIContextualAction {
//       // let college = myArrayShuff[indexPath.row]
//        var actionTitle: String = ""
//        if bookmarkArray.contains(myArray[myIndex] as! String){
//            actionTitle = "Remove Bookmark"
//        } else {
//            actionTitle = "Bookmark"
//        }
//        let action = UIContextualAction(style: .normal, title: actionTitle) { (action, view, completion) in
//
//            if bookmarkArray.contains(myArray[myIndex] as! String){
//                if let index = bookmarkArray.index(of: myArray[myIndex] as! String) {
//                    bookmarkArray.remove(at: index)
//                }
//                print(bookmarkArray)
//            } else {
//                bookmarkArray.append(myArray[myIndex] as! String)
//                print(bookmarkArray)
//            }
//
//
//           completion(true)
//        }
//        action.backgroundColor = UIColor(patternImage: UIImage(named: "Color2")!)
//        if bookmarkArray.contains(myArray[myIndex] as! String){
//            action.image = #imageLiteral(resourceName: "unCheckedBookmark")
//        } else {
//            action.image = #imageLiteral(resourceName: "bookmark-7")
//        }
//        return action
//    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredmyArray.count
        } else {
            return myArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

                
            var cell: CollegeTableViewCell! = tableView.dequeueReusableCell(withIdentifier: CollegeTableViewCell.identifier) as? CollegeTableViewCell
            if cell == nil {
                 cell =  CollegeTableViewCell(style: .default, reuseIdentifier: CollegeTableViewCell.identifier) as? CollegeTableViewCell
            }
            if isFiltering() {
                ///////
                
                
                let schoolKey = "\(filteredmyArray[indexPath.row])"
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
                    let imageName = "\(filteredmyArray[indexPath.row])2.png"
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
                
                
                
                /////////
                
            }else {
            
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
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        incomingFromBookmarks = false
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
}





