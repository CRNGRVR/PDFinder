//
//  RequestProtocol.swift
//  PDFinder
//
//  Created by Иван on 28.04.2023.
//

import Foundation

protocol RequestManagerInteraction{
    
    var progress: Double? { get set }
    
    func onDataReceivedAndLoaded(data: Data?, responseCode: Int?)
}
