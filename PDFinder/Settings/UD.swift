//
//  UD.swift
//  PDFinder
//
//  Created by Иван on 26.04.2023.
//

import Foundation

//  Синглтон, который служит только для хранения
//  и работы с строкой адреса сервера в UserDefaults.
struct UD{
    
    static let shared = UD()

    let key = "httpURL"
    
    
    func setURL(_ url: String){
        UserDefaults.standard.set(url, forKey: key)
    }
    
    func getURL() -> String{
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
}
