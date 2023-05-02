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
            .download("\(UD.shared.getURL())/\(code ?? "0")")
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
    
}
