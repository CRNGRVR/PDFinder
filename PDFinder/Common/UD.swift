//
//  UD.swift
//  PDFinder
//
//  Created by Иван on 26.04.2023.
//

import Foundation

//  Синглтон, который служит для работы с UserDefaults
struct UD{
    
    static let shared = UD()

    let keyURL = "httpURL"
    
    func setURL(_ url: String){
        UserDefaults.standard.set(url, forKey: keyURL)
    }
    
    func getURL() -> String{
        return UserDefaults.standard.string(forKey: keyURL) ?? ""
    }
}
