//
//  MainVM.swift
//  PDFinder
//
//  Created by Иван on 17.04.2023.
//

import Foundation
import Alamofire

class MainVM: ObservableObject{
    
    //  Навигация
    @Published var nav: NavVM
    
    //  Данные, пришедшие с сервера
    @Published var file: Data?
    
    init(nav: NavVM){
        
        self.nav = nav
        requestFile()
    }
    
    func requestFile(){
        
        AF
            .request("http://192.168.0.158:3000/\(nav.code!)")
            .response{ resp in
                
                if let data = resp.data{
                    
                    self.file = data
                    print("Data!")
                }
            }
    }
    
    func back(){
        
        nav.code = nil
        nav.currentScreen = "scan"
    }
}
