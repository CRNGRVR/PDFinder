//
//  ScanVM.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import Foundation
import AVFoundation
import AVKit

class ScanVM: ObservableObject, BarcodeInteraction{
    
    @Published var session: AVCaptureSession = .init()
    @Published var codeOutput: AVCaptureMetadataOutput = .init()
    
    @Published var isShow: Bool = false
    @Published var msg: String = ""
    
    //  Класс, реагирующий на попадание кода в камеру
    @Published var codeDelegate = CodeDelegate()
    
    init(){
        
        //  Для вызова местных методов из CodeDelegate
        codeDelegate.scanVM = self
        
        setUp()
    }
    
    
    //  Получение разрешения на использование камеры
    //  Вызывается в onAppear()
    func permissionRequestIfNotAuthorized(){
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized{
            return
        }
        else{
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {_ in})
        }
    }
    
    //  Конфигурирование сканера
    func setUp(){
        
        //  Поиск камеры
        let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices[0]

        do{
            
            //  Настройка ввода
            let input = try AVCaptureDeviceInput(device: device)

            session.beginConfiguration()
            
            session.addInput(input)
            
            session.addOutput(codeOutput)
            //  Добавить сюда необходимое
            codeOutput.metadataObjectTypes = [.code128]
            
            codeOutput.setMetadataObjectsDelegate(codeDelegate, queue: .main)
            
            session.commitConfiguration()
            
            //  Выполнения на фоновом потоке требует IDE
            DispatchQueue.global(qos: .default).async{
                self.session.startRunning()
            }
        }
        catch{
            print("Error.")
        }
    }
    
    
    //  Вызывается из CodeDelegate, когда код прочитан
    func readed(code: String) {
        print(code)
        
        msg = code
        isShow = true
    }
    
}
