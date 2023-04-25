//
//  MainVM.swift
//  PDFinder
//
//  Created by Иван on 17.04.2023.
//

import Foundation
import Alamofire

class PdfVM: ObservableObject{
    
    //  Навигация
    @Published var nav: NavVM
    
    //  Данные, пришедшие с сервера
    @Published var file: Data?
    
    @Published var isShowPanel = true
    
    init(nav: NavVM){
        
        self.nav = nav
        loadFile()
    }
    
    
    func loadFile(){
        
        if nav.isFileFromDB{
            self.file = nav.pdfAsData
        }
        else{
            requestFile()
        }
        
    }
    
    func requestFile(){
        
        AF
            .request("http://192.168.0.158:3000/\(nav.code ?? "0")")
            .response{ resp in
                
                print("requested")
                
                if let data = resp.data{
                    
                    print("data!!!")
                    
                    self.file = data
                    
                    //  Сохранение документа
                    self.nav.currentDocumentIdentifire = CD.shared.add(name: self.nav.code ?? "unknown", data: data)
                }
            }
    }
    
    func back(){
        
        nav.code = nil
        nav.currentScreen = nav.lastscreen
        nav.currentDocumentIdentifire = nil
    }
    
    func delete(){
        
        nav.currentScreen = nav.lastscreen
        CD.shared.delete(id: nav.currentDocumentIdentifire!)
    }
    
    func docClick(){
        isShowPanel.toggle()
    }
}
