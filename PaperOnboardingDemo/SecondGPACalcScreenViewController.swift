//
//  SecondGPACalcScreenViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/5/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//
var userAverageGpa: Double = 0
import UIKit

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
        userData.append("Class Name: \(className.text)")
        userData.append("Type Of Class: \(classType.text)")
        userData.append("Grade In Class: \(classGrade.text)")
        var userDataCount: Int = (userData.count)/3
        for i in userDataCount {
            var x = 1
            var y = 2
            var z = 3
            var classNameFromUserData: String = userData[x]
            var typeOfClassFromUserData: String = userData[y]
            var gradeInClassFromUserData: String = userData[z]
            classNameFromUserData = classNameFromUserData.replacingOccurrences(of: "Class Name: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            classNameFromUserData = classNameFromUserData.replacingOccurrences(of: "Type Of Class: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            classNameFromUserData = classNameFromUserData.replacingOccurrences(of: "Grade In Class: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            //
            typeOfClassFromUserData = typeOfClassFromUserData.replacingOccurrences(of: "Class Name: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            typeOfClassFromUserData = typeOfClassFromUserData.replacingOccurrences(of: "Type Of Class: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            typeOfClassFromUserData = typeOfClassFromUserData.replacingOccurrences(of: "Grade In Class: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            //
            gradeInClassFromUserData = gradeInClassFromUserData.replacingOccurrences(of: "Class Name: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            gradeInClassFromUserData = gradeInClassFromUserData.replacingOccurrences(of: "Type Of Class: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            gradeInClassFromUserData = classNameFromUserData.replacingOccurrences(of: "Grade In Class: ", with: "", options: NSString.CompareOptions.literal, range: nil)
            print("from print fucntion 1\(typeOfClassFromUserData)")
            print("from print fucntion 2\(gradeInClassFromUserData)")
            print("from print fucntion 3\(classNameFromUserData)")
            if gradeInClassFromUserData == "Honors"{
                if typeOfClassFromUserData == ""{
                    print("Error From Type Of Class If Loops")
                } else if typeOfClassFromUserData == "+A"{
                    userGpa.append(4.83)
                } else if typeOfClassFromUserData == "A"{
                    userGpa.append(4.50)
                } else if typeOfClassFromUserData == "-A"{
                    userGpa.append(4.17)
                } else if typeOfClassFromUserData == "+B"{
                    userGpa.append(3.83)
                } else if typeOfClassFromUserData == "B"{
                    userGpa.append(3.50)
                } else if typeOfClassFromUserData == "-B"{
                    userGpa.append(3.17)
                } else if typeOfClassFromUserData == "+C"{
                    userGpa.append(2.83)
                } else if typeOfClassFromUserData == "C"{
                    userGpa.append(2.50)
                } else if typeOfClassFromUserData == "-C"{
                    userGpa.append(2.17)
                } else if typeOfClassFromUserData == "+D"{
                    userGpa.append(1.83)
                } else if typeOfClassFromUserData == "D"{
                    userGpa.append(1.50)
                } else if typeOfClassFromUserData == "-D"{
                    userGpa.append(1.17)
                } else if typeOfClassFromUserData == "F"{
                    userGpa.append(0.50)
                } else {
                    print("Error From Type Of Class If Loops")
                }
            } else if gradeInClassFromUserData == "AP"{
                if typeOfClassFromUserData == ""{
                    print("Error From Type Of Class If Loops")
                } else if typeOfClassFromUserData == "+A"{
                    userGpa.append(5.33)
                } else if typeOfClassFromUserData == "A"{
                    userGpa.append(5.00)
                } else if typeOfClassFromUserData == "-A"{
                    userGpa.append(4.67)
                } else if typeOfClassFromUserData == "+B"{
                    userGpa.append(4.33)
                } else if typeOfClassFromUserData == "B"{
                    userGpa.append(4.00)
                } else if typeOfClassFromUserData == "-B"{
                    userGpa.append(3.67)
                } else if typeOfClassFromUserData == "+C"{
                    userGpa.append(3.33)
                } else if typeOfClassFromUserData == "C"{
                    userGpa.append(3.00)
                } else if typeOfClassFromUserData == "-C"{
                    userGpa.append(2.67)
                } else if typeOfClassFromUserData == "+D"{
                    userGpa.append(2.33)
                } else if typeOfClassFromUserData == "D"{
                    userGpa.append(2.00)
                } else if typeOfClassFromUserData == "-D"{
                    userGpa.append(1.67)
                } else if typeOfClassFromUserData == "F"{
                    userGpa.append(1.00)
                } else {
                    print("Error From Type Of Class If Loops")
                }
            } else if gradeInClassFromUserData == "DE"{
                if typeOfClassFromUserData == ""{
                    print("Error From Type Of Class If Loops")
                } else if typeOfClassFromUserData == "+A"{
                    userGpa.append(4.83)
                } else if typeOfClassFromUserData == "A"{
                    userGpa.append(4.50)
                } else if typeOfClassFromUserData == "-A"{
                    userGpa.append(4.17)
                } else if typeOfClassFromUserData == "+B"{
                    userGpa.append(3.83)
                } else if typeOfClassFromUserData == "B"{
                    userGpa.append(3.50)
                } else if typeOfClassFromUserData == "-B"{
                    userGpa.append(3.17)
                } else if typeOfClassFromUserData == "+C"{
                    userGpa.append(2.83)
                } else if typeOfClassFromUserData == "C"{
                    userGpa.append(2.50)
                } else if typeOfClassFromUserData == "-C"{
                    userGpa.append(2.17)
                } else if typeOfClassFromUserData == "+D"{
                    userGpa.append(1.83)
                } else if typeOfClassFromUserData == "D"{
                    userGpa.append(1.50)
                } else if typeOfClassFromUserData == "-D"{
                    userGpa.append(1.17)
                } else if typeOfClassFromUserData == "F"{
                    userGpa.append(0.50)
                } else {
                    print("Error From Type Of Class If Loops")
                }
            } else if gradeInClassFromUserData == "None of the above"{
                if typeOfClassFromUserData == ""{
                    print("Error From Type Of Class If Loops")
                } else if typeOfClassFromUserData == "+A"{
                    userGpa.append(4.33)
                } else if typeOfClassFromUserData == "A"{
                    userGpa.append(4.00)
                } else if typeOfClassFromUserData == "-A"{
                    userGpa.append(3.67)
                } else if typeOfClassFromUserData == "+B"{
                    userGpa.append(3.33)
                } else if typeOfClassFromUserData == "B"{
                    userGpa.append(3.00)
                } else if typeOfClassFromUserData == "-B"{
                    userGpa.append(2.67)
                } else if typeOfClassFromUserData == "+C"{
                    userGpa.append(2.33)
                } else if typeOfClassFromUserData == "C"{
                    userGpa.append(2.00)
                } else if typeOfClassFromUserData == "-C"{
                    userGpa.append(1.67)
                } else if typeOfClassFromUserData == "+D"{
                    userGpa.append(1.33)
                } else if typeOfClassFromUserData == "D"{
                    userGpa.append(1.00)
                } else if typeOfClassFromUserData == "-D"{
                    userGpa.append(0.67)
                } else if typeOfClassFromUserData == "F"{
                    userGpa.append(0.00)
                } else {
                    print("Error From Type Of Class If Loops")
                }
            } else {
                print("Error From Type Of Class If Loops")
            }
            x = x+3
            y = y+3
            z = z+3
        }
        userAverageGpa = (userGpa.reduce(0, +))/Double(userDataCount)
        print(userAverageGpa)
    }
    
    @IBAction func moreClassesTapped(_ sender: Any) {
        print("\(classType.text)")
        print("\(classGrade.text)")
        print("\(className.text)")
        userData.append("Class Name: \(className.text)")
        userData.append("Type Of Class: \(classType.text)")
        userData.append("Grade In Class: \(classGrade.text)")
        print("User Data Array: \(userData)")
    }
}
