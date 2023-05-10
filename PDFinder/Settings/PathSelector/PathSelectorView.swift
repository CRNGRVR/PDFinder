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
                
                Toggle(isOn: $pathSelectorVM.isShowStandartField, label: {Text("Использовать обычную адресную строку").font(.system(size: 15))})
                
                if pathSelectorVM.isShowStandartField{
                    
                    
                    
                    VStack{
                        longTf(text: $pathSelectorVM.fullText)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                else{
                    
                    HStack{
                        
                        tf(text: $pathSelectorVM.first)
                        pointVithSpacers()
                        tf(text: $pathSelectorVM.second)
                        pointVithSpacers()
                        tf(text: $pathSelectorVM.third)
                        pointVithSpacers()
                        tf(text: $pathSelectorVM.four)


                        if !pathSelectorVM.isPort80{
                            
                            
                            HStack{
                                
                                Spacer()
                                
                                VStack(alignment: .center){
                                    Text(":")
                                }
                                
                                Spacer()
                            }
                                
                            tf(text: $pathSelectorVM.port)
                        }
                    }

                    Spacer()

                    HStack{
                        
                       
                            
                            Button(action: {pathSelectorVM.selectHttp()}, label: {
                                ZStack{
                                    Color(pathSelectorVM.selection[0] ? "selectedBlue" : "closeGray")
                                    Text("HTTP")
                                        .foregroundColor(Color(pathSelectorVM.selection[0] ? "justWhite" : "selectedBlue"))
                                }
                            })
                            .frame(maxWidth: (UIScreen.main.bounds.width / 100) * 20, maxHeight: 35)
                            .cornerRadius(10)
                            
                        Spacer()
                        
                            Button(action: {pathSelectorVM.selectHttps()}, label: {
                                ZStack{
                                    Color(pathSelectorVM.selection[1] ? "selectedBlue" : "closeGray")
                                    Text("HTTPS")
                                        .foregroundColor(Color(pathSelectorVM.selection[1] ? "justWhite" : "selectedBlue"))
                                }
                            })
                            .frame(maxWidth: (UIScreen.main.bounds.width / 100) * 20, maxHeight: 35)
                            .cornerRadius(10)
                        
                        Spacer()
                        
                        Button(action: {pathSelectorVM.clickPort()}, label: {
                            ZStack{
                                Color(pathSelectorVM.isPort80 ? "selectedBlue" : "closeGray")
                                Text("HTTP-порт")
                                    .foregroundColor(Color(pathSelectorVM.isPort80 ? "justWhite" : "selectedBlue"))
                            }
                        })
                        .frame(maxWidth: (UIScreen.main.bounds.width / 100) * 40, maxHeight: 35)
                        .cornerRadius(10)
                        }
                    }
                    
                    
                    
                    Spacer()
                    
                    
                if !pathSelectorVM.isShowStandartField{
                    Text("http\(pathSelectorVM.httpOrS ? "" : "s")://\(pathSelectorVM.first).\(pathSelectorVM.second).\(pathSelectorVM.third).\(pathSelectorVM.four)\(pathSelectorVM.isPort80 ? "" : ":\(pathSelectorVM.port)" )/*")
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 15)
                }
                
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



struct longTf: View{
    
    @Binding var text: String
    
    var body: some View{
        ZStack{
            Color("closeGray")
            TextField("Введите полный адрес", text: $text)
                .padding(.leading, 15)
                .keyboardType(.URL)
        }
        .frame(maxWidth: .infinity, maxHeight: 45)
        .cornerRadius(10)

    }
}


struct pointVithSpacers: View{
    var body: some View{
        HStack{
            Spacer()
            Text(".")
            Spacer()
        }
        
    }
}
