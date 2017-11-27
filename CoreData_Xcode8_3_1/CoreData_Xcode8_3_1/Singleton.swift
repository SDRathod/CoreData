//
//  Singleton.swift
//  CoreData_Xcode8_3_1
//
//  Created by Samir Rathod on 27/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    static let sharedSingleton = Singleton()
    
    // MARK: -  Store and Retrive from UserDefaults
    
    func saveToUserDefault(value: String, forKey key:String)  {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key as String)
        defaults.synchronize()
    }
    
    func retriveFromUserDefault(key: String) -> String {
        let defaults = UserDefaults.standard
        if let strVal = defaults.string(forKey:key as String) {
            return strVal
        }
        else {
            return ("" as String?)!
        }
    }
    
    // MARK: -  String RemoveNull and Trim Method
    func removeNull (str:String) -> String {
        if (str == "<null>" || str == "(null)" || str == "N/A" || str == "n/a" || str.isEmpty) {
            return ""
        } else {
            return str
        }
    }
    
    // MARK: -  TextField Validation Method
    func validateEmail(strEmail: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: strEmail)
    }
    
    func validatePhoneNumber(strPhone: String) -> Bool {
        let phoneRegex: String = "[0-9]{8}([0-9]{1,3})?"
        let test = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return test.evaluate(with: strPhone)
    }

    func getImage(imgName : String) -> String{
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(imgName)
        if fileManager.fileExists(atPath: imagePAth){
           return imagePAth
        }else{
            print("No Image")
            return ""
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = (paths[0] as NSString).appendingPathComponent("PhotoDirectory")
        return documentsDirectory
    }
}
