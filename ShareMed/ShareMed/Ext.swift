//
//  Ext.swift
//  ShareMed
//
//  Created by Shrenika, Soma on 04/07/22.
//

import Foundation
import UIKit

func textFld(textField: UITextField){
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 10, width: textField.frame.width, height: 1.0)
    bottomLine.backgroundColor = UIColor(red: 110/255.0, green: 52/255.0, blue: 215/255.0, alpha: 1.0).cgColor
    textField.borderStyle = UITextField.BorderStyle.none
    textField.layer.addSublayer(bottomLine)
}

func textFld1(textField: UITextField){
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
    bottomLine.backgroundColor = UIColor(red: 110/255.0, green: 52/255.0, blue: 215/255.0, alpha: 1.0).cgColor
    textField.borderStyle = UITextField.BorderStyle.none
    textField.layer.addSublayer(bottomLine)
}
