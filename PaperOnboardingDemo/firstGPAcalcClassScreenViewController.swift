//
//  firstGPAcalcClassScreenViewController.swift
//  College Search
//
//  Created by Kunwar Sahni on 2/5/18.
//  Copyright © 2018 Kunwar Sahni. All rights reserved.
//

import UIKit

class firstGPAcalcClassScreenViewController: UIViewController, UIPickerViewDelegate,  UIPickerViewDataSource {

    @IBOutlet weak var gradeInClass: UITextField!
    var grades = ["+A", "A", "-A", "+B", "B", "-B", "+C", "C", "-C", "+D", "D", "-D", "F"]
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

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return grades.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gradeInClass.text = grades[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return grades[row]
    }
    @objc func donePicker() {
        
        gradeInClass.resignFirstResponder()
        
    }

}
