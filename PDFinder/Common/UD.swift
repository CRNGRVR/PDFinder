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

    let keyFullOrByPieces = "fullOrByPieces"    //  true - full
    
    //  Ключ полной строки адреса
    let keyFullURL = "fullURL"
    
    //  Ключи хранения элементов адреса
    let keyHttpOrS = "httpOrS"
    let keyURL1 = "httpURL1"
    let keyURL2 = "httpURL2"
    let keyURL3 = "httpURL3"
    let keyURL4 = "httpURL4"
    let keyPort = "port"
    
    //  Ключ режима
    let keyMode = "mode"
    
    //  Ключ для значения: было ли когда-нибудь запущено приложение
    let keyIsAppTryingGetPermission = "isAppRunnedYet"
    
    
    //  Строка с адресом
    func setFullURL(url: String){
        UserDefaults.standard.set(url, forKey: keyFullURL)
    }
    
    func getFullURL() -> String?{
        return UserDefaults.standard.string(forKey: keyFullURL)
    }
    
    
    //  Адрес сервера по кусочкам
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
    
    
    
    func setFullOrByPieces(isFull: Bool){
        UserDefaults.standard.set(isFull, forKey: keyFullOrByPieces)
    }
    
    func getFullOrByPieces() -> Bool{
        return UserDefaults.standard.bool(forKey: keyFullOrByPieces)
    }
    
    
    //  Итоговая строка для обращения к AF
    func getStringURL() -> String{
        
        if getFullOrByPieces(){
            
            //  Когда адрес целиком
            return "\(getFullURL() ?? "")/"
        }
        else{
            
            //  Когда адрес по кусочкам
            
            let elements = getElementsURL()
            
            return "http\(elements.httpOrS ? "" : "s")://\(elements.p1).\(elements.p2).\(elements.p3).\(elements.p4):\(elements.port)/"
        }
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
    
    
    
    //  Заполняется, когда происходит запрос на разрешение
    func setAppTryungGetPermission(){
        UserDefaults.standard.set(true, forKey: keyIsAppTryingGetPermission)
    }
    
    func resetAppTryingGetPermission(){
        UserDefaults.standard.set(false, forKey: keyIsAppTryingGetPermission)
    }
    
    func isAppTryingGetPermission() -> Bool{
        return UserDefaults.standard.bool(forKey: keyIsAppTryingGetPermission)
    }
}
