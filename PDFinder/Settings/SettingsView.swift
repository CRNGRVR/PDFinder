//
//  SettingsView.swift
//  PDFinder
//
//  Created by Иван on 26.04.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsVM = SettingsVM()
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Spacer()
                
                Text("Настройки")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
            }
            .padding(.top, 20)
            
            
            ZStack{
                Color("closeBlack")
                    .cornerRadius(4)
                
                VStack{
                    HStack{
                        
                        Image(systemName: "globe")
                            .foregroundColor(Color.blue)
                        
                        Text("Адрес сервера")
                        
                        Spacer()
                    }
                    .padding(.top, 15)
                    
                    Spacer()
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                
                
                HStack{
                    
                    TextField("Пример: https://192.168.0.0:3000", text: $settingsVM.currentPath)
                    Text("/Номер")
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 15)
            
            
            DocSpaceCard(memory: settingsVM.memoryWithDescr)
                .padding(.bottom, 15)
            
            DeleteButton(settingsVM: settingsVM)
            
            Spacer()
        }
    }
}


struct DocSpaceCard: View {
    
    var memory: String
    
    var body: some View{
        
        ZStack{
            Color("closeBlack")
                .cornerRadius(4)
            
            HStack{
                
                Image(systemName: "doc")
                    .foregroundColor(Color.green)
                
                Text("Документы")
                
                Spacer()
                
                Text(memory)
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct DeleteButton: View{
    
    @ObservedObject var settingsVM: SettingsVM
    
    var body: some View{
        
        ZStack{
            Color("closeBlack")
                .cornerRadius(4)
            
            HStack{
                
                Spacer()
                
                Button(action: {settingsVM.clickClear()}, label: {
                    Text("Удалить все документы")
                    .foregroundColor(Color.red)
                    
                })
                
                Spacer()
                
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}