//
//  ContentView.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import SwiftUI

struct ParentView: View {
    
    @ObservedObject var navVM = NavVM()
    
    var body: some View {
        
        switch navVM.currentScreen{

        case "scan":
            ScanView(nav: navVM)
        
        case "main":
            MainView(nav: navVM)

        default:
            Color.red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
