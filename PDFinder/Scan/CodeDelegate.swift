//
//  CodeDelegate.swift
//  PDFinder
//
//  Created by Иван on 16.04.2023.
//

import Foundation
import AVKit

//  NSObject наследуем, потому что иначе компилятор ругается
class CodeDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate, ObservableObject{
    
    var scanVM: BarcodeInteraction?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metaObjects = metadataObjects.first{
            
            //  guard условие else {если false}
            guard let readableObject = metaObjects as? AVMetadataMachineReadableCodeObject else {return}
            guard let scannedCode = readableObject.stringValue else {return}
        
            scanVM?.readed(code: scannedCode)
        }
    }
}
