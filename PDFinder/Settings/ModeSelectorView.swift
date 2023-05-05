//
//  ModeSelectorView.swift
//  PDFinder
//
//  Created by Иван on 05.05.2023.
//

import SwiftUI

struct ModeSelectorView: View{
    
    @ObservedObject var modeSelectorVM = ModeSelectorVM()
    
    var body: some View{
        ZStack{
            Color("closeBlack")
                .cornerRadius(8)
            
            
            VStack{
                
                HStack{
                    
                    Image(systemName: "rectangle.on.rectangle.angled")
                        .foregroundColor(Color.blue)
                    
                    Text("Режим работы с дубликатами")
                    
                    Spacer()
                }
                .padding(.leading, 15)
                .padding(.top, 15)
                
                
                HStack{
                    
                    ModeButton(isSelected: modeSelectorVM.isSelected[0], text: "Всегда\nспрашивать", nameImage: "questionmark.folder", action: modeSelectorVM.setModeQestion)
                    
                    ModeButton(isSelected: modeSelectorVM.isSelected[1], text: "Локальный\nпоиск", nameImage: "internaldrive", action: modeSelectorVM.setModeFindPriority)
                    
                    ModeButton(isSelected: modeSelectorVM.isSelected[2], text: "Всегда\nсохранять", nameImage: "doc.on.doc", action: modeSelectorVM.setModeDownload)
                    
                    ModeButton(isSelected: modeSelectorVM.isSelected[3], text: "Заменять\nна новый", nameImage: "arrow.triangle.2.circlepath.doc.on.clipboard", action: modeSelectorVM.setModeReplace)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 10)
                
                Spacer()
                
                Text(modeSelectorVM.currentDescription)
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .padding(.top, 5)
                    .foregroundColor(Color.gray)
                    
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, idealHeight: 300)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}


struct ModeButton: View{
    
    var isSelected: Bool
    
    let text: String
    let nameImage: String
    let action: () -> Void
    
    
    var body: some View{
        
        VStack{
            Button(action: {action()}, label: {
                
                ZStack{
                    Color(isSelected ? "selectedBlue" : "closeGray")
                    
                    Image(systemName: nameImage)
                        .font(.system(size: 25))
                        .foregroundColor(Color(isSelected ? "justWhite" : "selectedBlue"))
                }
            })
            .frame(width: 65, height: 65)
            .cornerRadius(8)
            
            Text(text)
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
        }
    }
}
