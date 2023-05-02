//
//  ScanVM.swift
//  PDFinder
//
//  Created by Иван on 15.04.2023.
//

import Foundation
import AVFoundation
import AVKit

class ScanVM: ObservableObject, BarcodeInteraction, RequestManagerInteraction{
    
    //  Навигация по приложению
    @Published var nav: NavVM
    
    @Published var session: AVCaptureSession = .init()
    @Published var codeOutput: AVCaptureMetadataOutput = .init()
    
    //  Для сообщения о возможной ошибке
    @Published var isShow: Bool = false
    @Published var msg: String = ""
    
    //  Класс, реагирующий на попадание кода в камеру
    @Published var codeDelegate = CodeDelegate()
    
    @Published var requestManager = RequestManager()
    
    //  Ориентация экрана. Используется для перерисовки слоя камеры
    //  в соответствии ориентации
    @Published var orientation: UIDeviceOrientation = UIDevice.current.orientation

    
    @Published var isShowSettingsSheet = false {
        
        //  Запуск сессии камеры, когда экран настроек убран
        //  И остановка, когда поднят
        didSet{
            
            if isShowSettingsSheet{
                session.stopRunning()
            }
            else{
                startCameraSession()
            }
        }
    }
    
    
    @Published var isDataDownloadingNow = false
    @Published var progress: Double?
    
    init(nav: NavVM){
        
        self.nav = nav
        
        nav.lastscreen = "scan"
        nav.isFileFromDB = false
        
        //  Для вызова местных методов из CodeDelegate
        codeDelegate.scanVM = self
        
        requestManager.scanVM = self
        
        setUp()
        
        //  Отслеживание системных уведомлений о изменении ориентации экрана
        NotificationCenter.default.addObserver(self, selector: #selector(self.orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    
    @objc func orientationChanged(_ notice: Notification){
        orientation = UIDevice.current.orientation
    }
    
    
    //  Получение разрешения на использование камеры
    //  Вызывается в onAppear()
    func permissionRequestIfNotAuthorized(){
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized{
            return
        }
        else{
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {_ in})
        }
    }
    
    //  Конфигурирование сканера
    func setUp(){
        
        //  Поиск камеры
        let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices[0]

        do{
            
            //  Настройка ввода
            let input = try AVCaptureDeviceInput(device: device)

            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(codeOutput)
            //  Добавить сюда необходимое
            codeOutput.metadataObjectTypes = [.code128]
            codeOutput.setMetadataObjectsDelegate(codeDelegate, queue: .main)
            session.commitConfiguration()
            
            //  Старт сессии в фоновом потоке
            startCameraSession()
        }
        catch{
            print("Error.")
        }
    }
    
    
    //  Вызывается из CodeDelegate, когда код прочитан
    func readed(code: String) {
    
        isDataDownloadingNow = true
        
        //  Выключение камеры
        session.stopRunning()
                
        requestManager.requestFile(code)
    
        //  Раньше здесь был переход
        //  Но теперь он в onDataReceived
    }
    
    //  Идёт сразу же после readed
    func onDataReceived(data: Data?, responseCode: Int?) {
        
        isDataDownloadingNow = false
        
        if responseCode == 200 && data != nil{
            
            nav.pdfAsData = data
            nav.currentScreen = "pdf"
        }
        else if responseCode == 404{
            
            msg = "На сервере нет такого файла"
            isShow = true
            
            startCameraSession()
        }
        else{
            
            msg = "Ошибка сети или сервера"
            isShow = true
            
            startCameraSession()
        }
    }
    
    func goToList(){
        
        nav.currentScreen = "list"
        session.stopRunning()
    }
    
    func showSettings(){
        isShowSettingsSheet = true
        session.stopRunning()
    }
    
    
    func startCameraSession(){
        DispatchQueue.global(qos: .default).async {
            self.session.startRunning()
        }
    }
    
}
