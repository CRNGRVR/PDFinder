//
//  SettingsVM.swift
//  PDFinder
//
//  Created by Иван on 26.04.2023.
//

import Foundation

class SettingsVM: ObservableObject{
    
    //  Адрес сервера
    //  Без пути до документа
    @Published var currentPath: String {
        
        didSet{
            saveURL()
        }
    }
    
    //  Количество памяти, занятое документами.
    //  Преобразовывается в строку, содержащую число
    //  и единицу измерения(байты, килобайты, мегабайты)
    @Published var memoryWithDescr: String
    
    init(){
        
        currentPath = UD.shared.getURL()
        memoryWithDescr = CD.shared.countOfBytesWithDescr()
    }
    
    func saveURL(){
        UD.shared.setURL(currentPath)
    }

    func clickClear(){
        CD.shared.deleteAll()
    }
}
