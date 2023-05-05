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
    let keyMode = "mode"
    
    //  Адрес сервера
    func setURL(_ url: String){
        UserDefaults.standard.set(url, forKey: keyURL)
    }
    
    func getURL() -> String{
        return UserDefaults.standard.string(forKey: keyURL) ?? ""
    }
    
    
    //  Режим сохранения/выбора
    func setAlwaysQuestion(){
        UserDefaults.standard.set("question", forKey: keyMode)
    }
    
    func setAlwaysFindInDbOrLoad(){
        UserDefaults.standard.set("find", forKey: keyMode)
    }
    
    func setAlwaysReplace(){
        UserDefaults.standard.set("replace", forKey: keyMode)
    }
    
    func setAlwaysDownload(){
        UserDefaults.standard.set("download", forKey: keyMode)
    }
    
    func getSelectedMode() -> String {
        return UserDefaults.standard.string(forKey: keyMode) ?? "1"
    }
}
