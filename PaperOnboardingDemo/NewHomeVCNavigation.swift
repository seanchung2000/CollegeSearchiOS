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
        let navigationTitleFont = UIFont(name: "Eveleth", size: 20)!
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: navigationTitleFont, NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor(patternImage: UIImage(named: "Rectangle 4")!)
    }

}
