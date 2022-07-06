//
//  RegisterViewController.swift
//  ShareMed
//
//  Created by Shrenika, Soma on 05/07/22.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var donateTime: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var medStatus: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var saltName: UITextField!
    @IBOutlet weak var expiry: UITextField!
    @IBOutlet weak var medName: UITextField!
    let thePicker = UIPickerView()
    let thePicker1 = UIPickerView()
    let data = ["Opened", "Closed"]
    let data1 = ["Before Expiry", "After Expiry"]
    override func viewDidLoad() {
        super.viewDidLoad()
        textFld1(textField: medName)
        textFld1(textField: expiry)
        textFld1(textField: saltName)
        textFld1(textField: quantity)
        textFld1(textField: medStatus)
        textFld1(textField: desc)
        textFld1(textField: donateTime)
        self.navigationController?.navigationBar.tintColor = .purple
        thePicker.tag = 10
        thePicker.delegate = self
        thePicker.dataSource = self
        medStatus.inputView = thePicker
        thePicker1.tag = 20
        thePicker1.delegate = self
        thePicker1.dataSource = self
        medStatus.inputView = thePicker
        donateTime.inputView = thePicker1
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        button.tintColor = .black
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        medStatus.inputAccessoryView = toolBar
        donateTime.inputAccessoryView = toolBar
    }
    @objc func action() {
          view.endEditing(true)
    }
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 10{
            return data.count
        }
        else{
            return data1.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 10{
            return data[row]
        }
        else{
            return data1[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 10{
            medStatus.text = data[row]
        }
        else{
            donateTime.text = data1[row]
        }
      
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == medStatus{
            self.thePicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(thePicker, didSelectRow: 0, inComponent: 0)
        }
        if textField == donateTime{
            self.thePicker1.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(thePicker1, didSelectRow: 0, inComponent: 0)
        }
    }
    
    
    @IBAction func registerClicked(_ sender: Any) {
    }
    
}
