//
//  Utilities.swift
//  WeTest
//
//  Created by Abdulrahman Sammy on 1/2/19.
//  Copyright © 2019 We. All rights reserved.
//


import UIKit
import NVActivityIndicatorView
class Utilities: NSObject {
    
    //Get Document's Directory 

    class func getDocumentsDirectory () -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentsPath
    }
    
    // Select and Deselect Button
    
    
    //Attributed Strings
    
    // Stroke through
    
    static func strokedAttributedString(strokedString: String) -> NSMutableAttributedString {
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: strokedString)
        attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    
    // Colored Range
    
    static func coloredAttributedString(fullString: String, fullStringColor: UIColor, subString: String, subStringColor: UIColor) -> NSMutableAttributedString {
        let range = (fullString as NSString).range(of: subString)
        let attributedString = NSMutableAttributedString(string:fullString)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: fullStringColor, range: NSRange(location: 0, length: fullString.characters.count))
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: subStringColor, range: range)
        
        return attributedString
    }
    
    // Show/Hide Status Bar
    
    class func toogleStatusBar(status: Bool) {
        UIApplication.shared.setStatusBarHidden(status, with: .none)
    }
    
    // Show/Hide Loader
    
    class func showLoader(view:UIView) {
        view.isUserInteractionEnabled = false
        let dimmedView = UIView(frame: view.frame)
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(ALPHA_COMPONENT)
        let color = UIColor(red: 100/255, green: 61/255, blue: 133/255, alpha: 1.0)
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: view.frame.midX - LOADER_WIDTH / 2, y: view.frame.midY - LOADER_WIDTH / 2, width: LOADER_WIDTH, height: LOADER_WIDTH), color: color)
        dimmedView.addSubview(activityIndicatorView)
        view.addSubview(dimmedView)
        activityIndicatorView.startAnimating()
    }
    class func hideLoader(view:UIView) {
        view.isUserInteractionEnabled = true
        let v = view.subviews.last
        v?.removeFromSuperview()
    }
    
    // Show Alert
    
    class func showAlertViewWithTitle(title:String , msg:String, cancelBtnTitle: String) {
        let alert = UIAlertView()
        alert.message = msg
        alert.title = title
        alert.message = msg
        alert.addButton(withTitle: cancelBtnTitle)
        alert.show()
    }
    
    class func showAlertControllerOverController(controller:UIViewController, withTitle:String?, message:String, action:[UIAlertAction]) {
        let alert = UIAlertController(title: withTitle, message: message,preferredStyle: UIAlertControllerStyle.alert)
        action.forEach { newAction in
            alert.addAction(newAction)
        }
        // Avoid presenting more than alert
        if controller.presentedViewController?.isKind(of:UIAlertController.self) == nil {
            controller.present(alert, animated: true, completion: nil)
        }
    }
    

    
    // Creates a UIColor from a Hex string
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

