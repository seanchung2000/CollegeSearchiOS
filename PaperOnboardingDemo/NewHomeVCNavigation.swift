//
//  NewHomeVCNavigation.swift
//  PaperOnboardingDemo
//
//  Created by Kunwar Sahni on 12/29/17.
//  Copyright © 2017 K. All rights reserved.
//

import UIKit
@IBDesignable
class NewHomeVCNavigation: UINavigationController {
    
    var collgeMatches: Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
        }
    }

}
