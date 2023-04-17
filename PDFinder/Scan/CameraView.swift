//
//  CameraView.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import SwiftUI
import AVKit


struct CameraView: UIViewRepresentable{
    
    @Binding var session: AVCaptureSession
    
    //  Размер основного view и размер слоя камеры
    var size: CGSize
    var orientation: UIDeviceOrientation
    
    
    func makeUIView(context: Context) -> UIView {
        
        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        
        //  Задание размера
        //  Можно и просто CGRect(origin: .zero, size: size)
        cameraLayer.frame = .init(origin: .zero, size: size)
        
        //  Обрезает слой с камерой по размерам
        cameraLayer.videoGravity = .resizeAspectFill
        
        
        switch orientation {
    
        case .portrait:
            cameraLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            
        case .landscapeLeft:
            cameraLayer.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
            
        case .landscapeRight:
            cameraLayer.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
            
        default:
            cameraLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        }
        
        
        //  Привязывает соответствие рамок камеры и рамок view
        //  дл возможности применения опций, таких как cornerRadius
        cameraLayer.masksToBounds = true
        
        //  Основное view, на которое накладывается камера
        let view = UIViewType(frame: CGRect(origin: .zero, size: size))
        
        
        //  Наложение камеры на view
        view.layer.addSublayer(cameraLayer)
        
        return view
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //  Пустота
    }
    
}
