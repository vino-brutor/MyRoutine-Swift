//
//  NotificationManager.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 17/06/25.
//

import UserNotifications

class NotificationManager {
    
    static public let shared = NotificationManager()
    
    
    private init() {}
    
    func scheduleNotification(with task: Task){
        guard let taskTitle = task.title, let taskTime = task.time, let taskDay = task.dayOfTheWeek else { return }
        
        let content = UNMutableNotificationContent() //declara o conteudo da notificacao
        content.title = taskTitle
        content.body = "🎯 Hora dessa rotina!!!"
        content.sound = .default
        
        //colcoa o horario da tasjk em um dateComponent
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: taskTime)
        
        //pega o dai da semana e atribui ao date component de acordo com a convencao
        switch taskDay {
                case "Dom": dateComponents.weekday = 1
                case "Seg": dateComponents.weekday = 2
                case "Ter": dateComponents.weekday = 3
                case "Qua": dateComponents.weekday = 4
                case "Qui": dateComponents.weekday = 5
                case "Sex": dateComponents.weekday = 6
                case "Sáb": dateComponents.weekday = 7
                default: break
        }
        
        //cria o trigger basedo na dateComponnet
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //cria a request da notificacao
        let request = UNNotificationRequest(identifier: taskTitle, content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao agendar notificacao: \(error)")
            }
        }
    }
}
