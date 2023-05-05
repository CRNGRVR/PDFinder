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
                
                
                
                HStack{
                    
                    tf(text: $pathSelectorVM.first)
                    Text(" . ")
                    tf(text: $pathSelectorVM.second)
                    Text(" . ")
                    tf(text: $pathSelectorVM.third)
                    Text(" . ")
                    tf(text: $pathSelectorVM.four)
                        
                    
                    if !pathSelectorVM.isPort80{
                        Text(" : ")
                            .padding(.bottom, 20)
                        tf(text: $pathSelectorVM.port)
                    }
                }
                
                
                
                HStack{
                    VStack{
                        
                        Button(action: {pathSelectorVM.selectHttp()}, label: {
                            ZStack{
                                Color(pathSelectorVM.selection[0] ? "selectedBlue" : "closeGray")
                                Text("HTTP")
                                    .foregroundColor(Color(pathSelectorVM.selection[0] ? "justWhite" : "selectedBlue"))
                            }
                        })
                        .frame(width: 70, height: 35)
                        .cornerRadius(10)
                        
                        Button(action: {pathSelectorVM.selectHttps()}, label: {
                            ZStack{
                                Color(pathSelectorVM.selection[1] ? "selectedBlue" : "closeGray")
                                Text("HTTPS")
                                    .foregroundColor(Color(pathSelectorVM.selection[1] ? "justWhite" : "selectedBlue"))
                            }
                        })
                        .frame(width: 70, height: 35)
                        .cornerRadius(10)
                    }
                    
                    Toggle(isOn: $pathSelectorVM.isPort80, label: {Text("Использовать стандартный порт")})
                }
                
                
                
                Spacer()
                
                
                Text("http\(pathSelectorVM.httpOrS ? "" : "s")://\(pathSelectorVM.first).\(pathSelectorVM.second).\(pathSelectorVM.third).\(pathSelectorVM.four)\(pathSelectorVM.isPort80 ? "" : ":\(pathSelectorVM.port)" )/*")
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 15)
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
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
        }
        .frame(width: 45, height: 45)
        .cornerRadius(10)
    }
}
