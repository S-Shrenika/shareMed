//
//  ScannerViewController.swift
//  ShareMed
//
//  Created by Shrenika, Soma on 05/07/22.
//

import UIKit

class ScannerViewController: UIViewController {

    @IBOutlet weak var topview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        topview.layer.shadowColor = UIColor.gray.cgColor
        topview.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        topview.layer.shadowOpacity = 1.0
        topview.layer.masksToBounds = false
        topview.layer.cornerRadius = 40.0
        topview.backgroundColor = UIColor(red: 110/255.0, green: 52/255.0, blue: 215/255.0, alpha: 1.0).withAlphaComponent(1.0)
        topview.isOpaque = false
        topview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

    }
    @IBAction func continueClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "register", sender: self)
    }
    
}
