//
//  Utils.swift
//  AppGateTest
//
//  Created by Enar GoMez on 31/01/22.
//

import Foundation
import UIKit

class Utils
{
    //// Valid if email's format is correct
    ///
    /// - Parameter testStr: string to test
    /// - Returns: true if the password is valid false for any else
    class func isValidEmail(_ testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return result
        
    }
    
    /// Valid if password's format is correct
    ///
    /// - Parameter testStr: string to test
    /// - Returns: true if the password is valid false for any else
    class func isValidPassword(_ testStr:String) -> Bool {
        
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let range = testStr.range(of: passwordRegex, options:.regularExpression)
        let result = range != nil ? true : false
        return result
        
    }
    
    
    /// Show a message in view
    /// - Parameters:
    ///   - view: controller to show message
    ///   - message: message to show
    class func showMessage (_ view: UIViewController, _ message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .gray
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 10
        
        view.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            alert.dismiss(animated: true)
        }
    }
    
    
    /// Return a date object from a string
    /// - Parameter strDate: string date
    /// - Returns: date
    class func getDateFrom(_ strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: strDate) ?? Date()
    }
}
