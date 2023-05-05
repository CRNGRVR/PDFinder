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

    let keyHttpOrS = "httpOrS"
    let keyURL1 = "httpURL1"
    let keyURL2 = "httpURL2"
    let keyURL3 = "httpURL3"
    let keyURL4 = "httpURL4"
    let keyPort = "port"
    
    let keyMode = "mode"
    
    //  Адрес сервера
    func setURL(urlElements: PathElements){
        
        UserDefaults.standard.set(urlElements.httpOrS, forKey: keyHttpOrS)
        
        UserDefaults.standard.set(urlElements.p1, forKey: keyURL1)
        UserDefaults.standard.set(urlElements.p2, forKey: keyURL2)
        UserDefaults.standard.set(urlElements.p3, forKey: keyURL3)
        UserDefaults.standard.set(urlElements.p4, forKey: keyURL4)
        
        UserDefaults.standard.set(urlElements.port, forKey: keyPort)
    }
    
    func getElementsURL() -> PathElements{
        
        let httpOrS = UserDefaults.standard.bool(forKey: keyHttpOrS)
        let p1 = UserDefaults.standard.string(forKey: keyURL1)
        let p2 = UserDefaults.standard.string(forKey: keyURL2)
        let p3 = UserDefaults.standard.string(forKey: keyURL3)
        let p4 = UserDefaults.standard.string(forKey: keyURL4)
        let port = UserDefaults.standard.string(forKey: keyPort)
        
        return PathElements(httpOrS: httpOrS, p1: p1 ?? "", p2: p2 ?? "", p3: p3 ?? "", p4: p4 ?? "", port: port ?? "")
    }
    
    func getStringURL() -> String{
        
        let elements = getElementsURL()
        
        return "http\(elements.httpOrS ? "s" : "")://\(elements.p1).\(elements.p2).\(elements.p3).\(elements.p4):\(elements.port)/"
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
