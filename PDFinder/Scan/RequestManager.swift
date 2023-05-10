//
//  RequestManage.swift
//  PDFinder
//
//  Created by Иван on 28.04.2023.
//

import Foundation
import Alamofire

class RequestManager{

    var scanVM: RequestManagerInteraction?
    
    var currentDocumentIdentifire: UUID?
    
    //  Запрос данных с сервера
    func requestFile(_ code: String?){
        
        AF
            .download("\(UD.shared.getStringURL())\(code ?? "0")")
            .responseData{ resp in
                
                if let data = resp.value{
                    
                    //  Сохранение документа
                    //  Функция сохранения возвращает идентификатор
                    self.currentDocumentIdentifire = CD.shared.add(name: code ?? "unknown", data: data)
                    
                    self.scanVM?.onDataReceivedAndLoaded(data: data, responseCode: resp.response?.statusCode)
                }
                else{
                    self.scanVM?.onDataReceivedAndLoaded(data: nil, responseCode: resp.response?.statusCode)
                }
            }
            .downloadProgress{ progress in
                
                self.scanVM?.progress = progress.fractionCompleted
            }
    }
    
    
    //  Функция для дубликатной опции "Заменить"
    func requestFileAndReplace(_ code: String?){
        
        AF
            .download("\(UD.shared.getStringURL())\(code ?? "0")")
            .responseData{ resp in
                
                if let data = resp.value{
                    
                    CD.shared.reload(item: CD.shared.find(name: code!)!, data: data)
                    self.currentDocumentIdentifire = CD.shared.find(name: code!)?.id
                    
                    self.scanVM?.onDataReceivedAndLoaded(data: data, responseCode: resp.response?.statusCode)
                }
                else{
                    self.scanVM?.onDataReceivedAndLoaded(data: nil, responseCode: resp.response?.statusCode)
                }
            }
            .downloadProgress{ progress in
                
                self.scanVM?.progress = progress.fractionCompleted
            }
    }


    //  Отмена запроса данных
    //  Будет доступна пользователю по нажатию кнопки
    func calcelRequest(){
        AF.cancelAllRequests()
    }
    
    
    
    func firstRequest(){
    
        AF
            .request("\(UD.shared.getStringURL())")
            .response{_ in}
    }
    
}
