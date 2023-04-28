//
//  Главное View, навигация в приложении происходит
//  путём переключения его дочерних элементов
//

import SwiftUI

struct ParentView: View {
    
    @ObservedObject var navVM = NavVM()
    
    var body: some View {
        
        switch navVM.currentScreen{

        case "scan":
            ScanView(nav: navVM)
        
        case "pdf":
            PdfView(nav: navVM)
            
        case "list":
            ListDocsView(nav: navVM)

        default:
            Color.red
        }
    }
}
