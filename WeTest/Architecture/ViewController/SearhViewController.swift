//
//  SearhViewController.swift
//  WeTest
//
//  Created by Abdulrahman Sammy on 1/2/19.
//  Copyright © 2019 We. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SearhViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var movieTableView: UITableView!
    var moviesArray = [MoviesitemEntity]()
    var moview_NextPage = true
    var pagenum:Int = 1
    var totalpagenum:Int = 0
    var searchresultdropDown = DropDown()
    let searchicon = UIImage(named: "searshicon")
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate =  self
        movieTableView.register(UINib(nibName: "MovieTableViewCell" , bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Search"
        searchTextField.setrightIcon(searchicon!)
         inintDrobDown ()
 
    }

////////   GET DROW DOWN PROPERTIES ////////

    func inintDrobDown () {
        
        searchresultdropDown.anchorView = searchTextField
        searchresultdropDown.bottomOffset = CGPoint(x: 0, y:(searchresultdropDown.anchorView?.plainView.bounds.height)!)
        
        searchresultdropDown.dataSource = User.searchresult()
        searchresultdropDown.reloadAllComponents()
        searchresultdropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.searchTextField.text = item
            self.moviesArray.removeAll()
            let link =  Constant.API_URL + self.searchTextField.text! + "&page=1"
            //self.getMovies(url: link)
            self.getmovieslogic(url: link, searchvalue:self.searchTextField.text!, scrollstate: false)
            
            self.searchresultdropDown.hide()
            
        }
    }
    
 ////////    TEXT FIELD START EDITING ////////
    func textFieldDidBeginEditing(_ textField: UITextField) {
     let searchresult = User.searchresult()
    
    
        if searchresult.isEmpty != true || User.searchresult() != [] {
            print(User.searchresult())
        
        }
         self.searchresultdropDown.show()
           print("no =",User.searchresult())

    }
    
////////    TEXT FIELD END EDITING ////////

    func textFieldDidEndEditing(_ textField: UITextField) {
        let txt_searchKey = searchTextField.text ?? ""
        self.searchresultdropDown.hide()

        if txt_searchKey == "" {return}
        
      let searchresult = User.searchresult()
      if searchresult.isEmpty != true || User.searchresult() != [] {
            print(User.searchresult())
        }
        
        let link =  Constant.API_URL + searchTextField.text! + "&page=1"
        getmovieslogic(url: link, searchvalue:searchTextField.text!, scrollstate: false)

        }
    

////////   GET MOVIE ITEM FUCION ////////

    func getmovieslogic (url:String,searchvalue:String,scrollstate:Bool) {
        Utilities.showLoader(view: self.view)
        MoviesLogic.MoviesLogicManager.getMovies(url: url, searchkey: searchvalue, scroll: scrollstate){
            (data) in
            Utilities.hideLoader(view: self.view)
            self.view.endEditing(true)

            if data is MovieEntity {
            let result = data as? MovieEntity

                if result?.moviesitem.isEmpty == false {
                    self.moviesArray.removeAll()
                    self.pagenum  = (result?.page)!
                    self.totalpagenum  = (result?.totalpage)!
                    
                    self.moviesArray  =  (result?.moviesitem)!
                    self.movieTableView.reloadData()

                    if scrollstate == false {
                        self.movieTableView.scrollToRow(at: [0,0], at: .middle, animated: true)
                    }
                    self.searchresultdropDown.dataSource = User.searchresult()
                    
                    self.searchresultdropDown.reloadAllComponents()
                }
        
            }
  
                
            }

        
    }

    
////////  CHECK IF TABLEVIEW SCROLLED TO BOTTOM   ////////

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if (movieTableView.contentOffset.y >= (movieTableView.contentSize.height - movieTableView.frame.size.height)){
            
            if   self.pagenum  ==  self.totalpagenum {return}
            let page = self.pagenum + 1
           let link =  Constant.API_URL +  self.searchTextField.text! + "n&page=" +   page.description
            getmovieslogic(url: link, searchvalue:searchTextField.text!, scrollstate: true)

     
        }
      
    }
    
    }


extension SearhViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let Object = moviesArray[indexPath.row]
        cell.setData(movie: Object)
       return cell
    }
   
}
