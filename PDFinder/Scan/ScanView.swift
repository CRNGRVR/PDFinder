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
                    .font(.system(size: 24, weight: .heavy))
                    .padding(.leading, 20)
                
                Spacer()
                
                Button(action: {scanVM.showSettings()}, label: {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 25))
                })
                .padding(.trailing, 20)
            }
            .padding(.top, 40)
            
            
            HStack{
                Button(action: {scanVM.goToList()}, label: {
                    Text("Перейти к ранее загруженным\nдокументам")
                        .multilineTextAlignment(.leading)
                    
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.blue)
                })
                .padding(.leading, 20)
                
                Spacer()
            }
            
            Spacer()
            
            //  Когда код считан и данные загружаются, то показывается
            //  значек загрузки, а камера скрывается
            if !scanVM.isDataDownloadingNow{
                
                GeometryReader{g in
                    CameraView(session: $scanVM.session, size: g.size, orientation: scanVM.orientation)
                        .cornerRadius(4)
                }
                .frame(width: 300, height: 150)
                
                       
                Image(systemName: "barcode.viewfinder")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 50))
                    .padding(.top, 20)
            }
            else{
                ActivityIndicator()
            }
                
            //  Показать шкалу, если идёт загрузка
            if scanVM.progress != nil{
               
                Gauge(value: scanVM.progress ?? 0, label: {})
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.top, 20)
            }
            
            if scanVM.isDataDownloadingNow{
                Button(action: {scanVM.cancelReq()}, label: {
                    Text("Отмена")
                        .foregroundColor(Color.red)
                        .padding(.top, 20)
                })
            }
            
            Spacer()
            Spacer()
        }
        .sheet(isPresented: $scanVM.isShowSettingsSheet){
            SettingsView()
        }
        
        .alert(isPresented: $scanVM.isShow, content: {Alert(title: Text(scanVM.msg))})
        .alert("Найден дубликат. Что делать?", isPresented: $scanVM.isPresentChoose, actions: {
            Button(action: {scanVM.find()}, label: {Text("Открыть схоранённое")})
            Button(action: {scanVM.download()}, label: {Text("Скачать")})
            Button(action: {scanVM.replace()}, label: {Text("Скачать и заменить")})
        })
        
        .onAppear{
            scanVM.permissionRequestIfNotAuthorized()
        }
    }
}
