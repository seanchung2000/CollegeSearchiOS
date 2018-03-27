//
//  SecondGPACalcScreenViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/5/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit

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
