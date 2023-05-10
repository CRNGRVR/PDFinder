//
//  PDFView.swift
//  PDFinder
//
//  Created by Иван on 17.04.2023.
//

import Foundation
import SwiftUI
import PDFKit

struct PDFReader: UIViewRepresentable{
    
    @State var data: Data?
    
    func makeUIView(context: Context) -> UIView {
        
        let pdfView = PDFView()
        
        if let data = data{
            pdfView.document = PDFDocument(data: data)
        }
        
        pdfView.scaleFactor = 0.6
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //  Пустота
    }
}
