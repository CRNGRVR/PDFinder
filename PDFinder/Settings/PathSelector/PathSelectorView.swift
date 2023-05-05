//
//  PathSelectorView.swift
//  PDFinder
//
//  Created by Иван on 05.05.2023.
//

import SwiftUI


struct PathSelectorView: View{
    
    @ObservedObject var pathSelectorVM = PathSelectorVM()
    
    
    var body: some View{
        ZStack{
            Color("closeBlack")
                .cornerRadius(8)
            
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
                
//                TextField("Пример: https://192.168.0.0:3000", text: $settingsVM.currentPath)
//                    //.keyboardType(.numberPad)
//                Text("/Номер")
                
                Text("http")
                Button(action: {
                    pathSelectorVM.changeHttpOrS()
                }, label: {
                    ZStack{
                        Color("justWhite")
                        Text(pathSelectorVM.httpOrS ? "s" : "")
                            .foregroundColor(Color.blue)
                    }
                })
                .frame(width: 20, height: 20)
                Text("://")
                HStack{
                    tf(text: $pathSelectorVM.first)
                    Text(".")
                    tf(text: $pathSelectorVM.second)
                    Text(".")
                    tf(text: $pathSelectorVM.third)
                    Text(".")
                    tf(text: $pathSelectorVM.four)
                    Text(":")
                    tf(text: $pathSelectorVM.port)
                    
                }
                
                
                
                Text("/num")
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
        }
        .frame(maxWidth: .infinity, idealHeight: 250)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}


struct tf: View{
    
    @Binding var text: String
    
    var body: some View{
        
        ZStack{
            
            Color("closeGray")
            TextField("", text: $text)
        }
        .frame(width: 30, height: 20)
    }
}
