//
//  NavVM.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import Foundation

//  Координатор курильщика
class NavVM: ObservableObject{
    
    @Published var currentScreen = "scan"
    var lastscreen = "scan"
    
    //  Зафиксированный в данный момент код
    //  Здесь для передачи в другие view
    @Published var code: String?
    
    //  Извлеченный документ из бд
    //  Извлекается на этапе выбора из списка
    @Published var pdfAsData: Data?
    
    //  Используется в PdfVM для определения происхождения данных
    //  если false, скачивается по адресу
    //  если true, извлекается из бд
    var isFileFromDB = false
    
    var currentDocumentIdentifire: UUID?
}
