//
//  CD.swift
//  PDFinder
//
//  Created by Иван on 25.04.2023.
//

import Foundation
import CoreData

struct CD{
    
    static let shared = CD()
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext{
        return container.viewContext
    }
    
    init(){
        container = NSPersistentContainer(name: "DocsModel")
        
        //  Не обрабатываю завершение загрузки
        container.loadPersistentStores(completionHandler: { _, _ in })
    }
    
    
    func getList() -> [Document] {
        
        let request = Document.fetchRequest()
        
        do{
            return try viewContext.fetch(request)
        }
        catch{
            return []
        }
    }
    
    func add(name: String, data: Data) -> UUID{
        
        let newItem = Document(context: viewContext)
        
        newItem.id = UUID()
        newItem.name = name
        newItem.data = data
        
        save()
        
        return newItem.id!
    }
    
    func delete(id: UUID){
        
        guard let item = find(id: id) else { return }
        
        viewContext.delete(item)
        save()
    }
    
    
    func find(id: UUID) -> Document?{
        
        let request = Document.fetchRequest()
        request.predicate = NSPredicate(format: "id = '\(id)'")
        
        do{
            return try viewContext.fetch(request)[0]
        }
        catch{
            print("Error(find).")
            return nil
        }
    }
    
    func save(){
        
        do{
            try viewContext.save()
        }
        catch{
            print("Error(save).")
        }
    }
    
    
    //  Подсчёт размера всех документов, хранимых локально
    func countOfBytesWithDescr() -> String{
        
        let request = Document.fetchRequest()
        
        do{
            let allDocs = try viewContext.fetch(request)
            
            var bytes = 0
            
            for item in allDocs{
                bytes += item.data?.count ?? 0
            }
            
            
            if bytes < 1024{
                return "\(bytes) байт"
            }
            else if bytes > 1024 && bytes < 1048576{ //1048576 б == 1 мб
                return "\(bytes / 1024) кбайт"
            }
            else{
                return "\(bytes / 1048576) мбайт"
            }
            
        }
        catch{
            print("Error(countOfBytes)")
            return "Ошибка вычисления"
        }
    }
    
    func deleteAll(){
        
        let request = Document.fetchRequest()
        
        var items: [Document]
        
        do{
            items = try viewContext.fetch(request)
        }
        catch{
            print("Error(deleteAll).")
            return
        }
        
        for item in items{
            viewContext.delete(item)
        }
        
        save()
    }
}
