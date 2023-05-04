//
//  ListDocsView.swift
//  PDFinder
//
//  Created by Иван on 24.04.2023.
//

import SwiftUI

struct ListDocsView: View {
    
    @ObservedObject var listDocsVM: ListDocsVM
    init(nav: NavVM){
        listDocsVM = ListDocsVM(nav: nav)
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Архив")
                    .foregroundColor(Color.white)
                    .font(.system(size: 24, weight: .heavy))
                    .padding(.leading, 20)
                
                Spacer()
                
                Button(action: {listDocsVM.goToScan()}, label: {
                    Image(systemName: "camera")
                        .font(.system(size: 25))
                })
                    .padding(.trailing, 20)
            }
            .padding(.top, 40)
            
            ScrollView(.vertical){
                VStack(spacing: 10){
                    
                    ForEach(listDocsVM.list){ item in
                        element(listDocsVM: listDocsVM, id: item.id!, name: item.name ?? "", date: item.date!)
                    }
                }
            }
        }
        .onAppear{
            listDocsVM.onScreenLoaded()
        }
    }
}


struct element: View{
    
    @ObservedObject var listDocsVM: ListDocsVM
    
    //  Идентификатор записи в бд
    let id: UUID
    
    //  Фактический номер документа
    let name: String
    
    //  Дата поиска
    let date: Date
    
    var body: some View{
        
        ZStack{
            Color("closeBlack")
                .cornerRadius(8)
            
            VStack{
                HStack{
                    Text(name)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.bottom, 1)
                
                HStack{
                    Text(listDocsVM.format(date: date))
                        .foregroundColor(Color.gray)
                        .font(.system(size: 13))
                        .padding(.leading, 20)
                    
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, idealHeight: 80)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .onTapGesture {
            listDocsVM.onItemClick(id: id)
        }
    }
}
