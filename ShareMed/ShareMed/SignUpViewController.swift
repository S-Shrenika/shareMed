//
//  SignUpViewController.swift
//  ShareMed
//
//  Created by Shrenika, Soma on 04/07/22.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var rePwdTxtFld: UITextField!
    @IBOutlet weak var pwdTxtFld: UITextField!
    @IBOutlet weak var dobTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var nameTxtFld: UITextField!
    var activeTextField:UITextField!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        textFld(textField: nameTxtFld)
        textFld(textField: emailTxtFld)
        textFld(textField: dobTxtFld)
        textFld(textField: pwdTxtFld)
        textFld(textField: rePwdTxtFld)
        nameTxtFld.delegate = self
        emailTxtFld.delegate = self
        pwdTxtFld.delegate = self
        rePwdTxtFld.delegate = self
        dobTxtFld.delegate = self
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dobTxtFld.inputView = datePicker
        dobTxtFld.inputAccessoryView = createToolBar()
    }
    func createToolBar() -> UIToolbar{
        let toolBar =  UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        doneBtn.tintColor = .black
        toolBar.setItems([doneBtn], animated: true)
        return toolBar
    }
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.dobTxtFld.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    func isPasswordValid( Password : String) -> Bool{
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$")
        return password.evaluate(with: Password)
    }
    func signuppostreq(){
        guard let url = URL(string: "http://127.0.0.1:8000/users") else{
            print("Error")
            return
        }
        let email = emailTxtFld.text!
        let pwd = pwdTxtFld.text!
        let name = nameTxtFld.text!
        let pwdreenter = rePwdTxtFld.text!
        let dob = dobTxtFld.text!
        let info: [String:String] = [
            "email":"\(email)",
            "password":"\(pwd)",
            "name": "\(name)",
            "dob": "\(dob)"
        ]
        let validmail = self.validateEmail(enteredEmail: email)
        let validpwd = isPasswordValid(Password: pwd)
        if validmail != false  && validpwd != false && pwd == pwdreenter
        {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: info, options: .fragmentsAllowed)
            let _ = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                else{
                    let jsonresponse = try? JSONSerialization.jsonObject(with: data!, options: [])
                    guard let jsonArray = jsonresponse! as? [String: Any] else {
                        print("fail")
                          return
                    }
                }
            }.resume()
        }
        if validmail == false{
            let alert = UIAlertController(title: "Wrong Email", message: "Incorrect email format", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { _ in
                self.emailTxtFld.text = ""
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        if validpwd == false{
            let alert = UIAlertController(title: "Incorrect Format", message: " Use minimum 8 characters, at least 1 Alphabet, 1 Number and 1 Special Character:", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { _ in
                self.pwdTxtFld.text = ""
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        if pwd != pwdreenter{
            let alert = UIAlertController(title: "Passwords don't match", message: "Please check your passwords and re-enter again", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { _ in
                self.rePwdTxtFld.text = ""
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func keyboardShown(notification:Notification){
        let info:NSDictionary = notification.userInfo as! NSDictionary
        let keyboardsize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.height - keyboardsize.height
        let editingTextFieldY = activeTextField.convert(activeTextField.bounds, to:self.view).minY
        if self.view.frame.minY >= 0{
            if editingTextFieldY>keyboardY-50
            {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y-(editingTextFieldY-(keyboardY-150)), width: self.view.bounds.width, height: self.view.bounds.height)
                }, completion: nil)
            }
        }
    }
    @objc func keyboardHidden(notification:Notification){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func createAccount(_ sender: UIButton) {
        signuppostreq()
        if validateEmail(enteredEmail: emailTxtFld.text!) != false {
            let alert = UIAlertController(title: "Registration Successful", message: "", preferredStyle: .alert)
            let act = UIAlertAction(title: "Ok", style: .default) { _ in
                //self.performSegue(withIdentifier: "signup", sender: self)
                print("successful")
            }
            alert.addAction(act)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension SignUpViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
