//
//  firstGPAcalcClassScreenViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/5/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit
var userData : Array = [""]
class firstGPAcalcClassScreenViewController: UIViewController, UIPickerViewDelegate,  UIPickerViewDataSource {

    var gradesPicker = true
    
    @IBOutlet weak var gradeInClass: UITextField!
    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var typeOfClass: UITextField!
    @IBAction func gradeInClassTapped(_ sender: Any) {
         gradesPicker = true
    }
    @IBAction func typeOfClass(_ sender: Any) {
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
        
        gradeInClass.inputView = picker
        gradeInClass.inputAccessoryView = toolBar
        typeOfClass.inputView = picker
        typeOfClass.inputAccessoryView = toolBar
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
            gradeInClass.text = grades[row]
        } else {
            typeOfClass.text = classTypes[row]
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
            gradeInClass.resignFirstResponder()
        } else {
            typeOfClass.resignFirstResponder()
        }
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        print("\(typeOfClass.text)")
        print("\(gradeInClass.text)")
        print("\(className.text)")
        userData.append("Class Name: \(String(describing: className.text))")
        userData.append("Type Of Class: \(String(describing: typeOfClass.text))")
        userData.append("Grade In Class: \(String(describing: gradeInClass.text))")
        print("User Data Array: \(userData)")
    }
    
}

