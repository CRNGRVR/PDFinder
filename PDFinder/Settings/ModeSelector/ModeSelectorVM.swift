//
//  ModeSelectorVM.swift
//  PDFinder
//
//  Created by Иван on 05.05.2023.
//

import Foundation

class ModeSelectorVM: ObservableObject {
    
    @Published var isSelected = [false, false, false, false]
    
    let modeDescriptions = [
        
        "При выборе \"Всегда спрашивать\" с каждым найденным дубликатом система будет предупреждать и спрашивать, что с ним сделать.",
        
        "Выбор \"Локальный поиск\" означает, что если Вы уже сканировали этот код и документ сохранился, то будет показана его локальная копия. В таком случае документ не будет скачиваться с сервера и Интернет-соединение не нужно.",

        "Выбрав \"Заменять на новый\" найденый документ в памяти с таким же именем будет удалён, а на его место загружен новый. Если необходимо оставлять старые версии документов, выберите \"Всегда сохранять\".",
        
        "Опция \"Всегда сохранять\" определяет, что при каждом сканировании кода будет загружена новая копия документа, при этом если был дубликат, то он останется в памяти."
        
    ]
    
    @Published var currentDescription: String = ""
    
    init(){
        
        indicatorInit()
    }
    
    
    //  Подсветка кнопки и выбор описания для информирования
    //  пользователя о выбранном режиме
    func indicatorInit(){
        
        let currentMode = UD.shared.getSelectedMode()
        
        switch currentMode{
            
        case "question":
            isSelected = [true, false, false, false]
            currentDescription = modeDescriptions[0]
            
        case "find":
            isSelected = [false, true, false, false]
            currentDescription = modeDescriptions[1]
            
        case "download":
            isSelected = [false, false, true, false]
            currentDescription = modeDescriptions[3]
            
        case "replace":
            isSelected = [false, false, false, true]
            currentDescription = modeDescriptions[2]
            
        
        default:
            isSelected = [true, false, false, false]
            currentDescription = modeDescriptions[0]
        }
    }
    
    
    //  Выбор режима
    func setModeQestion(){
        
        isSelected = [true, false, false, false]
        currentDescription = modeDescriptions[0]
        
        UD.shared.setAlwaysQuestion()
    }
    
    func setModeFindPriority(){
        isSelected = [false, true, false, false]
        currentDescription = modeDescriptions[1]
        
        UD.shared.setAlwaysFindInDbOrLoad()
    }
    
    func setModeReplace(){
        isSelected = [false, false, false, true]
        currentDescription = modeDescriptions[2]
        
        UD.shared.setAlwaysReplace()
    }
    
    func setModeDownload(){
        isSelected = [false, false, true, false]
        currentDescription = modeDescriptions[3]
        
        UD.shared.setAlwaysDownload()
    }
}
