//
//  ListDocsVM.swift
//  PDFinder
//
//  Created by Иван on 24.04.2023.
//

import Foundation

class ListDocsVM: ObservableObject{
    
    @Published var nav: NavVM
    
    @Published var list: [Document] = []
    
    init(nav: NavVM){
        
        self.nav = nav
        nav.lastscreen = "list"
        list = CD.shared.getList()
    }
    
    func onItemClick(id: UUID){
        
        let selected = CD.shared.find(id: id)
        
        nav.pdfAsData = selected?.data
        nav.currentDocumentIdentifire = selected?.id
        
        if nav.pdfAsData != nil{
            
            nav.isFileFromDB = true
            nav.currentScreen = "pdf"
        }
    }
    
    func goToScan(){
        nav.currentScreen = "scan"
    }
}
