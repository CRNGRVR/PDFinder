//
//  CodeDelegate.swift
//  PDFinder
//
//  Created by Иван on 16.04.2023.
//

import Foundation
import AVKit

//  NSObject наследуем, потому что компилятор ругается
class CodeDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate{
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metaObjects = metadataObjects.first{
            
            guard let readableObject = metaObjects as? AVMetadataMachineReadableCodeObject else {return}
            guard let scannedCode = readableObject.stringValue else {return}
            print(scannedCode)
        }
    }
}
