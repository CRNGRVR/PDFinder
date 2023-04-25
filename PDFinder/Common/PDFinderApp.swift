//
//  Created 15.04.2023.
//
//  Это приложение первоначально задумывалось как заготовка для сф.
//  Тут не очень хорошо продумана архитектура, впервые использовал такое понятие как "делегат"
//  Познакомился с фреймворками AVKit и PDFKit, впервые использовал протокол UIViewRepresentable
//  

import SwiftUI

@main
struct PDFinderApp: App {
    var body: some Scene {
        WindowGroup {
            ParentView()
                .preferredColorScheme(.dark)
        }
    }
}
