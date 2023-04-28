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
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.leading, 20)
                
                Spacer()
                
                Button(action: {listDocsVM.goToScan()}, label: {Image(systemName: "camera")})
                    .padding(.trailing, 20)
            }
            .padding(.top, 40)
            
            ScrollView(.vertical){
                VStack{
                    
                    ForEach(listDocsVM.list){ item in
                        element(listDocsVM: listDocsVM, id: item.id!, name: item.name ?? "")
                    }
                }
            }
        }
    }
}


struct element: View{
    
    @ObservedObject var listDocsVM: ListDocsVM
    
    //  Идентификатор записи в бд
    let id: UUID
    
    //  Фактический номер документа
    let name: String
    
    var body: some View{
        
        ZStack{
            Color("closeBlack")
                .cornerRadius(4)
            
            HStack{
                Text(name)
                    .foregroundColor(Color.white)
                    .padding(.leading, 20)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, idealHeight: 50)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .onTapGesture {
            listDocsVM.onItemClick(id: id)
        }
    }
}
