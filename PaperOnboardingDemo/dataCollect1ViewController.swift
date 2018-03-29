//
//  dataCollect1ViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 3/26/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit
import SVProgressHUD
class dataCollect1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if currentReachabilityStatus == .notReachable {
            SVProgressHUD.show(withStatus: "Not Connected to Internet")
            
        } else if currentReachabilityStatus == .reachableViaWiFi{
            SVProgressHUD.dismiss()
        } else if currentReachabilityStatus == .reachableViaWWAN{
            SVProgressHUD.dismiss()
        } else {
            print("Error")
        }
        // Do any additional setup after loading the view.
    }
}
