//
//  SecondGPACalcScreenViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/5/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//
var userAverageGpa: Double = 0
var x: Int = 0
var y: Int = 1
var z: Int = 2
import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseFirestore
import Foundation
import Crashlytics
import SVProgressHUD
import CoreData
extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0..<self).makeIterator()
    }
}

class SecondGPACalcScreenViewController: UIViewController, UIPickerViewDelegate,  UIPickerViewDataSource {

    var gradesPicker = true

    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var classGrade: UITextField!
    @IBOutlet weak var classType: UITextField!
    @IBAction func classGradeTapped(_ sender: Any) {
        gradesPicker = true
    }
    @IBAction func classTypeTapped(_ sender: Any) {
        gradesPicker = false
    }
    
    var grades = ["+A", "A", "-A", "+B", "B", "-B", "+C", "C", "-C", "+D", "D", "-D", "F"]
    var classTypes = ["AP", "Honors", "DE", "None of the above"]
    var picker = UIPickerView()
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
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(firstGPAcalcClassScreenViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([/*cancelButton,*/ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        classGrade.inputView = picker
        classGrade.inputAccessoryView = toolBar
        classType.inputView = picker
        classType.inputAccessoryView = toolBar
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(gradesPicker){
            return grades.count
        } else {
            return classTypes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(gradesPicker){
            classGrade.text = grades[row]
        } else {
            classType.text = classTypes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(gradesPicker){
            return grades[row]
        } else {
            return classTypes[row]
        }
    }
    @objc func donePicker() {
        if(gradesPicker){
            classGrade.resignFirstResponder()
        } else {
            classType.resignFirstResponder()
        }
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        if className.text == "" {
            self.createAlert(titleText: "Error", messageText: "Class must have a name")
        } else if classType.text == "" {
            self.createAlert(titleText: "Error", messageText: "Class must have a type")
        } else if classGrade.text == ""{
            self.createAlert(titleText: "Error", messageText: "Class must have a grade")
        } else {
        calculateUserData()
        }
    }
    
    @IBAction func moreClassesTapped(_ sender: Any) {
        if className.text == "" {
            self.createAlert(titleText: "Error", messageText: "Class must have a name")
        } else if classType.text == "" {
            self.createAlert(titleText: "Error", messageText: "Class must have a type")
        } else if classGrade.text == ""{
            self.createAlert(titleText: "Error", messageText: "Class must have a grade")
        } else {
            userData.append("Class Name: \(className.text)")
            userData.append("Type Of Class: \(classType.text)")
            userData.append("Grade In Class: \(classGrade.text)")
        }
    }
    
    func calculateUserData () {
        userData.append("Class Name: \(className.text)")
        userData.append("Type Of Class: \(classType.text)")
        userData.append("Grade In Class: \(classGrade.text)")
        /*
        var x: Int = 1
        var y: Int = 2
        var z: Int = 3
        */
        var loopTimes: Int = (userData.count)/3
        for i in loopTimes {
            var calcUserClassName = userData[x]
            var calcUserClassType = userData[y]
            var calcUserClassGrade = userData[z]
            calcUserClassType = calcUserClassType.replacingOccurrences(of: "Type Of Class: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            calcUserClassGrade = calcUserClassGrade.replacingOccurrences(of: "Grade In Class: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            if calcUserClassType == "Optional(\"Honors\")"{
                if calcUserClassGrade == "Optional(\"+A\")"{
                    userGpa.append(4.83)
                } else if calcUserClassGrade == "Optional(\"A\")"{
                    userGpa.append(4.50)
                } else if calcUserClassGrade == "Optional(\"-A\")"{
                    userGpa.append(4.17)
                } else if calcUserClassGrade == "Optional(\"+B\")"{
                    userGpa.append(3.83)
                } else if calcUserClassGrade == "Optional(\"B\")"{
                    userGpa.append(3.50)
                } else if calcUserClassGrade == "Optional(\"-B\")"{
                    userGpa.append(3.17)
                } else if calcUserClassGrade == "Optional(\"+C\")"{
                    userGpa.append(2.83)
                } else if calcUserClassGrade == "Optional(\"C\")"{
                    userGpa.append(2.50)
                } else if calcUserClassGrade == "Optional(\"-C\")"{
                    userGpa.append(2.17)
                } else if calcUserClassGrade == "Optional(\"+D\")"{
                    userGpa.append(1.83)
                } else if calcUserClassGrade == "Optional(\"D\")"{
                    userGpa.append(1.50)
                } else if calcUserClassGrade == "Optional(\"-D\")"{
                    userGpa.append(1.17)
                } else if calcUserClassGrade == "Optional(\"F\")"{
                    userGpa.append(0.50)
                } else {
                    print("Error From Type Of Class If Loops")
                }
            } else if calcUserClassType == "Optional(\"AP\")" {
                
                if calcUserClassGrade == "Optional(\"+A\")" {
                    userGpa.append(5.33)
                } else if calcUserClassGrade == "Optional(\"A\")"{
                    userGpa.append(5.00)
                } else if calcUserClassGrade == "Optional(\"-A\")"{
                    userGpa.append(4.67)
                } else if calcUserClassGrade == "Optional(\"+B\")"{
                    userGpa.append(4.33)
                } else if calcUserClassGrade == "Optional(\"B\")"{
                    userGpa.append(4.00)
                } else if calcUserClassGrade == "Optional(\"-B\")"{
                    userGpa.append(3.67)
                } else if calcUserClassGrade == "Optional(\"+C\")"{
                    userGpa.append(3.33)
                } else if calcUserClassGrade == "Optional(\"C\")"{
                    userGpa.append(3.00)
                } else if calcUserClassGrade == "Optional(\"-C\")"{
                    userGpa.append(2.67)
                } else if calcUserClassGrade == "Optional(\"+D\")"{
                    userGpa.append(2.33)
                } else if calcUserClassGrade == "Optional(\"D\")"{
                    userGpa.append(2.00)
                } else if calcUserClassGrade == "Optional(\"-D\")"{
                    userGpa.append(1.67)
                } else if calcUserClassGrade == "Optional(\"F\")"{
                    userGpa.append(1.00)
                } else {
                    print("Error From Type Of Class If Loops")
                }
            } else if calcUserClassType == "Optional(\"DE\")"{
                if calcUserClassGrade == "Optional(\"+A\")"{
                    userGpa.append(4.83)
                } else if calcUserClassGrade == "Optional(\"A\")"{
                    userGpa.append(4.50)
                } else if calcUserClassGrade == "Optional(\"-A\")"{
                    userGpa.append(4.17)
                } else if calcUserClassGrade == "Optional(\"+B\")"{
                    userGpa.append(3.83)
                } else if calcUserClassGrade == "Optional(\"B\")"{
                    userGpa.append(3.50)
                } else if calcUserClassGrade == "Optional(\"-B\")"{
                    userGpa.append(3.17)
                } else if calcUserClassGrade == "Optional(\"+C\")"{
                    userGpa.append(2.83)
                } else if calcUserClassGrade == "Optional(\"C\")"{
                    userGpa.append(2.50)
                } else if calcUserClassGrade == "Optional(\"-C\")"{
                    userGpa.append(2.17)
                } else if calcUserClassGrade == "Optional(\"+D\")"{
                    userGpa.append(1.83)
                } else if calcUserClassGrade == "Optional(\"D\")"{
                    userGpa.append(1.50)
                } else if calcUserClassGrade == "Optional(\"-D\")"{
                    userGpa.append(1.17)
                } else if calcUserClassGrade == "Optional(\"F\")"{
                    userGpa.append(0.50)
                } else {
                    print("Error From Type Of Class If Loops")
                }
            } else if calcUserClassType == "Optional(\"None of the above\")"{
                if calcUserClassGrade == "Optional(\"+A\")"{
                    userGpa.append(4.33)
                } else if calcUserClassGrade == "Optional(\"A\")"{
                    userGpa.append(4.00)
                } else if calcUserClassGrade == "Optional(\"-A\")"{
                    userGpa.append(3.67)
                } else if calcUserClassGrade == "Optional(\"+B\")"{
                    userGpa.append(3.33)
                } else if calcUserClassGrade == "Optional(\"B\")"{
                    userGpa.append(3.00)
                } else if calcUserClassGrade == "Optional(\"-B\")"{
                    userGpa.append(2.67)
                } else if calcUserClassGrade == "Optional(\"+C\")"{
                    userGpa.append(2.33)
                } else if calcUserClassGrade == "Optional(\"C\")"{
                    userGpa.append(2.00)
                } else if calcUserClassGrade == "Optional(\"-C\")"{
                    userGpa.append(1.67)
                } else if calcUserClassGrade == "Optional(\"+D\")"{
                    userGpa.append(1.33)
                } else if calcUserClassGrade == "Optional(\"D\")"{
                    userGpa.append(1.00)
                } else if calcUserClassGrade == "Optional(\"-D\")"{
                    userGpa.append(0.67)
                } else if calcUserClassGrade == "Optional(\"F\")"{
                    userGpa.append(0.00)
                } else {
                    print("Error From Type Of Class If Loops")
                }
            }
            y = y + 3
            x = x + 3
            z = z + 3
        }
        SVProgressHUD.show(withStatus: "Calculating GPA")
        userAverageGpa = (userGpa.reduce(0, +))/Double(loopTimes)
        print(userAverageGpa)
        let userID: String = (Auth.auth().currentUser?.uid)!
        let db = Firestore.firestore()
        db.collection("Users").document("\(userID)").collection("GPA").document("0").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        db.collection("Users").document("\(userID)").collection("GPA").document("\(userAverageGpa)").setData([
            "GPA": "\(userAverageGpa)"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        SVProgressHUD.dismiss()
    }
    
    func createAlert (titleText : String , messageText: String) {
        
        let alert = UIAlertController (title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            
        }))        
        self.present(alert, animated: true, completion: nil)
        
    }
}
