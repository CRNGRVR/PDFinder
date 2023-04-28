
import Foundation

//  Координатор курильщика
class NavVM: ObservableObject{
    
    //  Текущий экран, выставляется в ParentView
    @Published var currentScreen = "scan"
    
    //  Последний активный экран до входа в читалку.
    //  Служит для возвращения из читалки туда, откуда был
    //  произведён вход
    var lastscreen = "scan"
    
    
    //  Зафиксированный в данный момент код
    //  Здесь для передачи в другие view
    @Published var code: String?
    
    //  Извлеченный документ из бд
    //  Извлекается на этапе выбора из списка
    @Published var pdfAsData: Data?
    
    //  Используется в PdfVM для определения происхождения данных
    //  если false, скачивается по адресу
    //  если true, извлекается из бд
    var isFileFromDB = false
    
    //  Идентификатор документа, используется при выборе из списка
    var currentDocumentIdentifire: UUID?
}
