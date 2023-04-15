//
//  ScanView.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import SwiftUI
import AVFoundation
import AVKit

struct ScanView: View {
    
    @ObservedObject var scanVM = ScanVM()
    
    var body: some View {
        VStack{
            
            Text("Приложение работает")
                
            CameraView(session: $scanVM.session)
        }
        .onAppear{
            scanVM.permissionRequestIfNotAuthorized()
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
