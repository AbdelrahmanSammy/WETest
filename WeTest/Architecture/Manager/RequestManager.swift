//
//  RequestManager.swift
//  WeTest
//
//  Created by Abdulrahman Sammy on 1/2/19.
//  Copyright © 2019 We. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON



class RequestManager: NSObject {
    static let Request = RequestManager()
    
 ////////////// TAKE THE REQUEST PARAMETER LIKE URL ANG GET JSON DATA
    func requestWithParameters(andURL: String,Header: HTTPHeaders? = nil,Meth:HTTPMethod, Parparameters: [String:AnyObject]? = nil ,  Result:@escaping (_ result : Any)->() ) {
        
        print("URL = " , andURL)
        
        Alamofire.request(andURL, method: Meth, parameters: Parparameters, encoding: JSONEncoding.default, headers: Header).validate(statusCode: 200..<400)
            .responseJSON {
                response in
                
                switch response.result {
                    
                case .success:
                    print("Validation Successful",response.result.value)
                    guard let values = JSON (response.result.value as Any) as? JSON else{
                        return
                    }
                    Result(values)
                    print(values)
                    
                    break
                case .failure(let error):
                var values:JSON = JSON(response.data as Any)
                    print("error body =",values)
                     if let mss = values["message"].string  {
                        Result(mss)
                    }
                    if let Message = values["errors"][0].string {
                        Result(Message)
                    }
                   
                    else{
                        print("ERROR \(error.localizedDescription))")
                        Result(error.localizedDescription)
                                            }
                    
                    break
                }
        }
        
        
        
    }
    
    
}
