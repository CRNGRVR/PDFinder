//
//  ScanVM.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import Foundation
import AVFoundation

class ScanVM: ObservableObject{
    
    init(){
        
        permissionRequestIfNotAuthorized()
    }
    
    
    
    
    //  Получение разрешения на использование камеры
    func permissionRequestIfNotAuthorized(){
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized{
            return
        }
        else{
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {_ in})
        }
    }
    
    
    
}
