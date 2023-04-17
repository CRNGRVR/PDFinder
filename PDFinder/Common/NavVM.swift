//
//  NavVM.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import Foundation

class NavVM: ObservableObject{
    
    @Published var currentScreen = "scan"
    
    //  Зафиксированный в данный момент код
    //  Здесь для передачи в другие view
    @Published var code: String?
}
