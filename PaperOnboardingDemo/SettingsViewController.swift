//
//  SettingsViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/7/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit
import Crashlytics


class SettingsViewController: UIViewController {

    @IBAction func websiteButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://interadaptive.com")! as URL, options: [:], completionHandler: nil)
    }
    @IBAction func feebackButton(_ sender: Any) {
        Answers.logCustomEvent(withName: "Feedback Pressed",
                                       customAttributes: [:])
        UIApplication.shared.open(URL(string: "https://interadaptive.com/feedback")! as URL, options: [:], completionHandler: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
