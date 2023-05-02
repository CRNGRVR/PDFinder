//
//  ActivityIndicator.swift
//  PDFinder
//
//  Created by Иван on 29.04.2023.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable{
    
    func makeUIView(context: Context) -> UIView {
        
        let spinner = UIActivityIndicatorView()
        spinner.frame = .init(origin: .zero, size: CGSize(width: 100, height: 100))
        spinner.startAnimating()
        
        return spinner
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
