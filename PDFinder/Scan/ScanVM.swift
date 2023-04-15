//
//  ScanVM.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import Foundation
import AVFoundation
import AVKit

class ScanVM: ObservableObject{
    
    @Published var session: AVCaptureSession = .init()
    
    init(){
        
        permissionRequestIfNotAuthorized()
        setUp()
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
    
    
    func setUp(){
        
        let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
        
        print(device)
        
        do{
            let input = try AVCaptureDeviceInput(device: device!)

            session.beginConfiguration()
            session.addInput(input)
            session.commitConfiguration()
            session.startRunning()
        }
        catch{
            print("Ye djj,ot rfgtw")
        }
    }
    
}
