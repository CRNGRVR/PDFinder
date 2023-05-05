//
//  PathSelectorVM.swift
//  PDFinder
//
//  Created by Иван on 05.05.2023.
//

import Foundation

class PathSelectorVM: ObservableObject{
    
    @Published var httpOrS = false{didSet{saveURL()}}
    
    @Published var first = ""{didSet{saveURL()}}
    @Published var second = ""{didSet{saveURL()}}
    @Published var third = ""{didSet{saveURL()}}
    @Published var four = ""{didSet{saveURL()}}
    
    @Published var port = ""{didSet{saveURL()}}
    
    init(){
        
        let elements = UD.shared.getElementsURL()
        
        httpOrS = elements.httpOrS
        first = elements.p1
        second = elements.p2
        third = elements.p3
        four = elements.p4
        port = elements.port
    }
    
    
    func saveURL(){
        
        UD.shared.setURL(urlElements: PathElements(httpOrS: httpOrS, p1: first, p2: second, p3: third, p4: four, port: port))
    }
    
    func changeHttpOrS(){
        httpOrS.toggle()
    }
    
    
}
