//
//  gpaCalcViewController.swift
//  
//
//  Created by Kunwar Sahni on 2/3/18.
//

import UIKit

class gpaCalcViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var isItAP = false
        var isItHonors = false
        var isItDE = false
        var grade = 0
        var gpa: Double = 0
        if (isItAP){
            if (grade == 97) {
                gpa = 4.3 + 1
            } else if (grade == 93) {
                gpa = 4.0 + 1
            } else if (grade == 90) {
                gpa = 3.7 + 1
            } else if (grade == 89) {
                gpa = 3.3 + 1
            } else if (grade == 86) {
                gpa = 3.0 + 1
            } else if (grade == 80) {
                gpa = 2.7 + 1
            } else if (grade == 77) {
                gpa = 2.3 + 1
            } else if (grade == 73) {
                gpa = 2.0 + 1
            } else if (grade == 70) {
                gpa = 1.7 + 1
            } else if (grade == 67) {
                gpa = 1.3 + 1
            } else if (grade == 63) {
                gpa = 1.0 + 1
            } else if (grade == 60) {
                gpa = 0.7 + 1
            } else if (grade < 60) {
                gpa = 0.0 + 1
            }
        } else if (isItHonors){
            if (grade == 97) {
                gpa = 4.3 + 0.5
            } else if (grade == 93) {
                gpa = 4.0 + 0.5
            } else if (grade == 90) {
                gpa = 3.7 + 0.5
            } else if (grade == 89) {
                gpa = 3.3 + 0.5
            } else if (grade == 86) {
                gpa = 3.0 + 0.5
            } else if (grade == 80) {
                gpa = 2.7 + 0.5
            } else if (grade == 77) {
                gpa = 2.3 + 0.5
            } else if (grade == 73) {
                gpa = 2.0 + 0.5
            } else if (grade == 70) {
                gpa = 1.7 + 0.5
            } else if (grade == 67) {
                gpa = 1.3 + 0.5
            } else if (grade == 63) {
                gpa = 1.0 + 0.5
            } else if (grade == 60) {
                gpa = 0.7 + 0.5
            } else if (grade < 60) {
                gpa = 0.0 + 0.5
            }
        } else if (isItDE){
            if (grade == 97) {
                gpa = 4.3 + 0.5
            } else if (grade == 93) {
                gpa = 4.0 + 0.5
            } else if (grade == 90) {
                gpa = 3.7 + 0.5
            } else if (grade == 89) {
                gpa = 3.3 + 0.5
            } else if (grade == 86) {
                gpa = 3.0 + 0.5
            } else if (grade == 80) {
                gpa = 2.7 + 0.5
            } else if (grade == 77) {
                gpa = 2.3 + 0.5
            } else if (grade == 73) {
                gpa = 2.0 + 0.5
            } else if (grade == 70) {
                gpa = 1.7 + 0.5
            } else if (grade == 67) {
                gpa = 1.3 + 0.5
            } else if (grade == 63) {
                gpa = 1.0 + 0.5
            } else if (grade == 60) {
                gpa = 0.7 + 0.5
            } else if (grade < 60) {
                gpa = 0.0 + 0.5
            }
        } else {
            if (grade == 97) {
                gpa = 4.3
            } else if (grade == 93) {
                gpa = 4.0
            } else if (grade == 90) {
                gpa = 3.7
            } else if (grade == 89) {
                gpa = 3.3
            } else if (grade == 86) {
                gpa = 3.0
            } else if (grade == 80) {
                gpa = 2.7
            } else if (grade == 77) {
                gpa = 2.3
            } else if (grade == 73) {
                gpa = 2.0
            } else if (grade == 70) {
                gpa = 1.7
            } else if (grade == 67) {
                gpa = 1.3
            } else if (grade == 63) {
                gpa = 1.0
            } else if (grade == 60) {
                gpa = 0.7
            } else if (grade < 60) {
                gpa = 0.0
            }
        }
    }
}
