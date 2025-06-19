//
//  AppDelegate.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 28/05/25.
//

import UIKit
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func requestNotificationPermission() {
        //pede a atuorização
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Erro ao pedir permissão para notificações: \(error)")
            }
            print("Autoriação concedida? \(granted)")
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    //delegate pra mostrar a notificacao mesmo com o app aberto
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let context = persistenceContainer.viewContext
        Persistence.shared.context = context
        
        requestNotificationPermission()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MinhaRotinaModel")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError()
            }
        })
      
        return container
    }()

    func context() -> NSManagedObjectContext {
        return persistenceContainer.viewContext
    }
    
    func saveContext () {
        let context = persistenceContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

