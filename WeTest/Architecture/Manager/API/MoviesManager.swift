//
//  MoviesManager.swift
//  WeTest
//
//  Created by Abdulrahman Sammy on 1/2/19.
//  Copyright © 2019 We. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class MoviesManager: NSObject {
    static let Manager = MoviesManager()
    
    //////////// GET  JSON DATA FROM REQUEST MANAGER FILE AND SET IT IN MOVIE ENTITY OBJECT
    func MoviesM(movieslink:String,Result:@escaping (_ result : Any)->()) {

        RequestManager.Request.requestWithParameters(andURL: movieslink, Header: nil,Meth: .get, Parparameters: nil ){ (data) in
           
    ///////////IF REPSONS GET SUCCESS SEND IT HERE

            if let result = data as? JSON {
                let itemObject = MovieEntity()
                itemObject.page = result["page"].intValue
                itemObject.totalpage = result["total_pages"].intValue
                for (_,subJson):(String, JSON) in result["results"] {
                    
                    let imagepath = Constant.IMAGE_URL + subJson["poster_path"].stringValue
                    
                    print("imagepath =",imagepath)
                    let Object = MoviesitemEntity(id: subJson["id"].intValue, title: subJson["title"].stringValue, posterPath: imagepath, overview: subJson["overview"].stringValue, releaseDate: subJson["release_date"].stringValue)
                    
                    itemObject.moviesitem.append( Object)
                 
                    
                }
                
                Result(itemObject)
                
            }
                
                
            else {
        ///////////IF RESPONS GET FILLUERE SEND IT HERE
                
                Result(data as! String)
            }
            
        }
        
        
    }
    
    
    
}
