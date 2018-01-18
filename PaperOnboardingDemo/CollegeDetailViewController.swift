//
//  CollegeDetailViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 1/16/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit

class CollegeDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var averageGpa: UILabel!
    
    @IBOutlet weak var averageSat: UILabel!
    
    @IBOutlet weak var averaeAct: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = myArray[myIndex] as! String
        
    }


}
