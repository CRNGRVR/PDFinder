//
//  PathSelectorVM.swift
//  PDFinder
//
//  Created by Иван on 05.05.2023.
//

import Foundation

class PathSelectorVM: ObservableObject{
    
    //  true - http
    @Published var httpOrS = false {didSet{saveURL()}}
    
    @Published var first = "" {didSet{saveURL()}}
    @Published var second = "" {didSet{saveURL()}}
    @Published var third = "" {didSet{saveURL()}}
    @Published var four = "" {didSet{saveURL()}}
    
    @Published var port = "" {didSet{saveURL()}}
    
    //  Индикация кнопок выбора http/https
    @Published var selection = [false, false]
    
    //  Toggle стандартный порт
    @Published var isPort80 = false{
        
        didSet{
            if isPort80{
                port = "80"
            }
            else{
                port = ""
            }
        }
    }
    
    
    
    
    @Published var isShowStandartField = false{
        didSet{
            if isShowStandartField{
                UD.shared.setFullOrByPieces(isFull: true)
            }
            else
            {
                UD.shared.setFullOrByPieces(isFull: false)
            }
        }
    }
    
    
    @Published var fullText = ""{
        didSet{
            saveURL()
        }
    }
    
    init(){
        
        let elements = UD.shared.getElementsURL()
        httpOrS = elements.httpOrS
        
        if httpOrS{
            selection = [true, false]
        }
        else
        {
            selection = [false, true]
        }
        
        first = elements.p1
        second = elements.p2
        third = elements.p3
        four = elements.p4
        port = elements.port
        
        
        fullText = UD.shared.getFullURL() ?? ""
        
        isShowStandartField = UD.shared.getFullOrByPieces()
    }
    
    
    func saveURL(){
        
        if isShowStandartField{
            UD.shared.setFullURL(url: fullText)
        }
        else{
            UD.shared.setURL(urlElements: PathElements(httpOrS: httpOrS, p1: first, p2: second, p3: third, p4: four, port: port))
        }
        
        UD.shared.resetAppTryingGetPermission()
    }
    
    
    func selectHttp(){
        httpOrS = true
        selection = [true, false]
    }
    
    func selectHttps(){
        httpOrS = false
        selection = [false, true]
    }
    
    func clickPort(){
        isPort80.toggle()
    }
}
