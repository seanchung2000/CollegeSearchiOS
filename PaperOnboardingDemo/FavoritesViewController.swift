//
//  FavoritesViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/19/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseStorage
import SVProgressHUD

let myArrayShuffBookmarks = bookmarkArray
var incomingFromBookmarks: Bool = false



class CollegeTableViewCell2: UITableViewCell {
    
    static let identifier = "CollegeTableViewCell2"
//    @IBOutlet weak var collegeName: UILabel!
//    @IBOutlet weak var collegeCampusImage: UIImageView!

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


class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print("View Appeared")
        print(myArrayShuffBookmarks.count)
    }
    
    @IBOutlet weak var tableView: UITableView!
    //TABLE VIEW OUTLET
    
    var imageCache = [String:UIImage]()
    
    override func viewDidLoad() {
        incomingFromBookmarks = false
        super.viewDidLoad()
        print(myArrayShuffBookmarks)
        print(myArrayShuffBookmarks.count)


        if let index = bookmarkArray.index(of: "") {
            bookmarkArray.remove(at: index)
        }
        
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "Color2")!)
            navigationController?.navigationBar.topItem?.title = "Your Bookmarks"
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
        } else {
            navigationController?.navigationBar.topItem?.title = "Your Bookmarks"
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

    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArrayShuffBookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CollegeTableViewCell2.identifier) as! CollegeTableViewCell2
           // if cell == nil {
            //    cell =  CollegeTableViewCell2(style: .default, reuseIdentifier: CollegeTableViewCell2.identifier) as? CollegeTableViewCell2
           // }
        
            //let schoolKey = "\(myArrayShuffBookmarks[indexPath.row])"
            //cell.collegeName.text = schoolKey
            cell.collegeName.text = "\(myArrayShuffBookmarks[indexPath.row])"
            //     cell.collegeLocation.text = "\(locationArray[indexPath.row])"
            
            // cell.textLabel?.font = UIFont(name:"Eveleth", size:20)
            //cell.textLabel?.textColor = UIColor.white
            //cell.backgroundColor = getRandomColor()
            
            
            
            let clearView = UIView()
            clearView.backgroundColor = UIColor.clear // Whatever color you like
            UITableViewCell.appearance().selectedBackgroundView = clearView
            
            
            if let image = imageCache["\(myArrayShuffBookmarks[indexPath.row])"] {
                cell.collegeCampusImage?.image = image
            } else {
                let imageName = "\(myArrayShuffBookmarks[indexPath.row])2.png"
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
                            strongSelf.imageCache["\(myArrayShuffBookmarks[indexPath.row])"] = imageData
                        }
                        
                    })
                    cell.dataTask?.resume()
                    
                })
            }
            
            
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        incomingFromBookmarks = true
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue2", sender: self)
    }
    
    func reloadtTableView () {
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
}





