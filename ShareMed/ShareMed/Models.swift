//
//  Models.swift
//  ShareMed
//
//  Created by Shrenika, Soma on 04/07/22.
//

import Foundation
import UIKit

struct Response: Codable{
    var access_token: String
    var token_type: String
    var owner_id: Int
}
struct ownerDetails: Codable{
    var id: Int
    var email: String
    var name: String
    var dob: String
}
