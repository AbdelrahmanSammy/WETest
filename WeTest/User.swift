//
//  User.swift
//  WeTest
//
//  Created by Abdulrahman Sammy on 1/2/19.
//  Copyright © 2019 We. All rights reserved.
//

import Foundation
class User: NSObject {
    
    class func searchresult() -> [String] {
       
        return  UserDefaults.standard.stringArray(forKey: "searchresult") ?? []
    }
    
    class func setsearchresult(searchresult:[String]) {
        UserDefaults.standard.set(searchresult, forKey: "searchresult")
    }
    
    
}
