//
//  HomeViewController.swift
//  ShareMed
//
//  Created by Shrenika, Soma on 04/07/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var topview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        makegetreq()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        topview.layer.shadowColor = UIColor.gray.cgColor
        topview.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        topview.layer.shadowOpacity = 1.0
        topview.layer.masksToBounds = false
        topview.layer.cornerRadius = 40.0
        topview.backgroundColor = UIColor(red: 110/255.0, green: 52/255.0, blue: 215/255.0, alpha: 1.0).withAlphaComponent(1.0)
        topview.isOpaque = false
        topview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    func makegetreq(){
        let ownr = UserDefaults.standard.object(forKey: "ownerId")
        guard let url = URL(string: "http://127.0.0.1:8000/user/\(ownr!)") else{
            print("Error")
            return
        }
        getreq(url: url) { arraydata, error in
            DispatchQueue.main.async {
                self.welcomeLbl.text = "Welcome, \(arraydata!.name)!"
                self.welcomeLbl.textColor = .white
            }
        }
    }
    func getreq(url: URL,completion:@escaping (ownerDetails?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(UserDefaults.standard.object(forKey: "accessToken")!)", forHTTPHeaderField: "Authorization")
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                let result = try? JSONDecoder().decode(ownerDetails.self, from: data)
                if result != nil{
                    completion(result,nil)
                }
                else{
                    completion(nil, error)
                }
            }
            else{
                completion(nil,error)
            }
    }.resume()
    }
}
