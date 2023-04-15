//
//  CameraView.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import SwiftUI
import AVFoundation
import AVKit


struct CameraView: UIViewRepresentable{
    
    @Binding var session: AVCaptureSession
    var frameSize: CGSize
    
    
    func makeUIView(context: Context) -> UIView {
        
        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        
        let view = UIViewType(frame: CGRect(origin: .zero, size: frameSize))
        
        cameraLayer.frame = .init(origin: .zero, size: frameSize)
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        
        view.backgroundColor = .clear
        view.layer.addSublayer(cameraLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}
