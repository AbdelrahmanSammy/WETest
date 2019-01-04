//
//  MoviesLogic.swift
//  WeTest
//
//  Created by Abdulrahman Sammy on 1/2/19.
//  Copyright © 2019 We. All rights reserved.
//

import Foundation

class MoviesLogic:NSObject {
    static let MoviesLogicManager = MoviesLogic()

    var moview_NextPage = true
    var pagenum:Int = 1
    var totalpagenum:Int = 0
    var movieobject = MovieEntity ()
    
    ///////////////// GET DATA FROM MOVIES MANAGER FILE AND PROCCESS IT
    func getMovies (url:String,searchkey:String,scroll:Bool,Result:@escaping (_ result : Any)->()){
    ////////////// SEND THE MOVIE ENTITY OBJECT IF REQUEST SUCESS TO VIEWCONTROLLER TO PRESENT IT
        MoviesManager.Manager.MoviesM(movieslink: url){
            (data) in

            if data is MovieEntity {
                if scroll == false {
                    self.movieobject.page = 0
                    self.movieobject.totalpage = 0
                    self.movieobject.moviesitem.removeAll()
                    
                }
                
                let result = data as? MovieEntity
           
                
                self.movieobject.page =  (result?.page)!
                self.movieobject.totalpage = (result?.totalpage)!
                
                if result?.moviesitem.isEmpty == false {
                    
                    for item in (result?.moviesitem)! {
                        
                        self.movieobject.moviesitem.append(item)
                    }
          
                    self.appendSearchResult(searchvlaue:searchkey)
                    Result(self.movieobject)
                }
                    
                else {
                    Utilities.showAlertViewWithTitle(title: "No search result!", msg: "", cancelBtnTitle: "Cancel")
                      Result("noresult")
                  }
                
                
            }
                
            else
            {
                let result = data as? String
                Utilities.showAlertViewWithTitle(title: result!, msg: "", cancelBtnTitle: "Cancel")
                
                Result("Fail")

                
            }
            

         

      
        }
        
    }
    ////////  CHECK IF SEARCH KEY EXIST BEFOR OR NOT AMD IF NOT ADD IT TO USER DEFAULT WITH LENGTH ARRAY 10
    func appendSearchResult (searchvlaue:String){
        
        var searcharray = User.searchresult()
        print("search array =",searcharray)
        for item in User.searchresult() {
            
            if item == searchvlaue
            {
                
                return
            }
            
        }
        if searcharray.count == 10 {
            
            searcharray.remove(at: 9)
            
        }
        searcharray.insert(searchvlaue, at: 0)
        User.setsearchresult(searchresult: searcharray)
        print(" User.searchresult()=", User.searchresult())
        
        
    }
 
}
