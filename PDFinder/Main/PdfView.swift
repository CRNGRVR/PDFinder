//
//  MainView.swift
//  PDFinder
//
//  Created by Иван on 17.04.2023.
//

import SwiftUI

struct PdfView: View {
    
    @ObservedObject var pdfVM: PdfVM
    init(nav: NavVM){
        pdfVM = PdfVM(nav: nav)
    }
    
    var body: some View {
        ZStack{
            
            if pdfVM.file != nil{
                PDFReader(data: pdfVM.file)
                    .onTapGesture {
                        pdfVM.docClick()
                    }
            }
            
            
            if pdfVM.isShowPanel{
                VStack(spacing: 0){
                    ZStack{
                        Color.white
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .opacity(0.7)
                        
                        HStack{
                            Button(action: {pdfVM.back()}, label: {Image(systemName: "arrowshape.turn.up.backward")})
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Button(action: {pdfVM.delete()}, label: {Image(systemName: "trash").foregroundColor(Color.red)})
                                .padding(.trailing, 20)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    
                    Spacer()
                }
            }
        }
    }
}
