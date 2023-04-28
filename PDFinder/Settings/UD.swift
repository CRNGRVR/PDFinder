//
//  UD.swift
//  PDFinder
//
//  Created by Иван on 26.04.2023.
//

import Foundation

struct UD{
    
    static let shared = UD()
    
    var httpURL = ""
    let key = "httpURL"
    
    init(){
        if let url = UserDefaults.standard.string(forKey: key){
            httpURL = url
        }
    }
    
    
    func setURL(_ url: String){
        UserDefaults.standard.set(url, forKey: key)
    }
    
    func getURL() -> String{
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
}
