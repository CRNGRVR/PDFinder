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
            .padding(.bottom, 10)
            
            
            ScrollView(.vertical, showsIndicators: false){
                
                ModeSelectorView()
                    .padding(.bottom, 5)
                
                PathSelectorView()
                    .padding(.bottom, 5)
                
                DocSpaceCard(memory: settingsVM.memoryWithDescr)
                    .padding(.bottom, 5)
                
                DeleteButton(settingsVM: settingsVM)
                    .padding(.bottom, 10)
            }
        }
    }
}



struct DocSpaceCard: View {
    
    var memory: String
    
    var body: some View{
        
        ZStack{
            Color("closeBlack")
                .cornerRadius(8)
            
            HStack{
                
                Image(systemName: "doc")
                    .foregroundColor(Color.green)
                
                Text("Документы")
                
                Spacer()
                
                Text(memory)
                    .foregroundColor(Color.gray)
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
        }
        .frame(maxWidth: .infinity, idealHeight: 50)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct DeleteButton: View{
    
    @ObservedObject var settingsVM: SettingsVM
    
    var body: some View{
        
        ZStack{
            Color("closeBlack")
                .cornerRadius(8)
            
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
        .frame(maxWidth: .infinity, idealHeight: 50)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
