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
        
        memoryWithDescr = "Вычисление..."
        calculateMemoryInBackground()
    }
    
    func saveURL(){
        UD.shared.setURL(currentPath)
    }

    func clickClear(){
        
        memoryWithDescr = "Перерасчёт..."
        
        CD.shared.deleteAll()
        calculateMemoryInBackground()
    }
    
    
    func calculateMemoryInBackground(){
        
        //  Расчёт занятого места - обращение к бд, при большом объёме
        //  данных крайне времязатратно. Чтобы не останавливать поток,
        //  работающий с интерфейсом эта задача перенесена в фон.
        //
        //  При открытии настроек пользователь не ждёт открытия самих настроек,
        //  а только подгрузки данных в уже появившемся с основного потока окне.
        DispatchQueue.main.async {
            self.memoryWithDescr = CD.shared.countOfBytesWithDescr()
        }
    }
    
    
    
}
