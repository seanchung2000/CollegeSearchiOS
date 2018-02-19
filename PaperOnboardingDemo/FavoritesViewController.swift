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

var myArray2: NSArray = ["2"]
var myIndex2: Int = 0

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var imageCache = [String:UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "College"))
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.blue
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
