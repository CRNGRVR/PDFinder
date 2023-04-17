//
//  MainView.swift
//  PDFinder
//
//  Created by Иван on 17.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var mainVM: MainVM
    init(nav: NavVM){
        mainVM = MainVM(nav: nav)
    }
    
    var body: some View {
        ZStack{
            
            if mainVM.file != nil{
                PDFReader(data: mainVM.file)
                    .onTapGesture {
                        print("tapped")
                    }
            }
            
            
            VStack(spacing: 0){
                ZStack{
                    Color.white
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .opacity(0.7)
                    
                    Button(action: {mainVM.back()}, label: {Image(systemName: "arrowshape.turn.up.backward")})
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                Spacer()
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
