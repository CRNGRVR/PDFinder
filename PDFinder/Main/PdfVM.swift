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
            .request("\(UD.shared.httpURL)/\(nav.code ?? "0")")
            .response{ resp in
                                
                if let data = resp.data{
                    
                    self.file = data
                    
                    //  Сохранение документа
                    //  Функция сохранения возвращает идентификатор
                    self.nav.currentDocumentIdentifire = CD.shared.add(name: self.nav.code ?? "unknown", data: data)
                }
            }
    }
    
    //  Возвращение назад.
    //  Кнопка на панели действий
    func back(){
        
        nav.code = nil
        nav.currentScreen = nav.lastscreen
        nav.currentDocumentIdentifire = nil
    }
    
    //  Удаление документа из панели действий
    func delete(){
        
        nav.currentScreen = nav.lastscreen
        CD.shared.delete(id: nav.currentDocumentIdentifire!)
    }
    
    //  Нажатие по области документа.
    //  Скрывает или показывает верхнюю панель действий
    func docClick(){
        isShowPanel.toggle()
    }
}
