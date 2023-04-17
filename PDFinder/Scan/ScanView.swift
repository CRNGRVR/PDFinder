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
    
    @ObservedObject var scanVM: ScanVM
    init(nav: NavVM){
        scanVM = ScanVM(nav: nav)
    }
    
    var body: some View {
        
        VStack{
            
            HStack{
                Text("Поместите штрих-код в область сканнера")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.leading, 20)
                
                Spacer()
            }
            .padding(.top, 40)
            
            
            HStack{
                Button(action: {}, label: {
                    Text("Перейти к ранее загруженным\nдокументам")
                        .multilineTextAlignment(.leading)
                    
                        .font(.system(size: 14))
                        .foregroundColor(Color.blue)
                })
                .padding(.leading, 20)
                
                Spacer()
            }
            
            Spacer()
            
            GeometryReader{g in
                CameraView(session: $scanVM.session, size: g.size)
                    .cornerRadius(4)
            }
            .frame(width: 300, height: 150)
            
                   
                Image(systemName: "barcode.viewfinder")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 50))
                    .padding(.top, 20)
                
            
            Spacer()
            Spacer()
        }
        
        .alert(isPresented: $scanVM.isShow, content: {Alert(title: Text(scanVM.msg))})
        
        .onAppear{
            scanVM.permissionRequestIfNotAuthorized()
        }
    }
}

//struct ScanView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScanView()
//    }
//}
