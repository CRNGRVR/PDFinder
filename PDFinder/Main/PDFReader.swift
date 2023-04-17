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
        pdfView.document = PDFDocument(data: data!)
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //  Пустота
    }
}
