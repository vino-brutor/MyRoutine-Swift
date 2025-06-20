import Foundation
import CoreData
import UIKit

class Persistence {
    static let shared = Persistence()
    
    var context: NSManagedObjectContext?
    
    func addTask(title: String, dayOfTheWeek: String, time: Date, icon: String, colorName: String) {
        guard let context else { return }
        
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.title = title
        newTask.dayOfTheWeek = dayOfTheWeek
        newTask.time = time
        newTask.iconName = icon
        newTask.colorName = colorName
        newTask.orderIndex = getMaxOrderIndex(for: dayOfTheWeek) + 1
        
        print(newTask)
        
        save()
    }
    
    func getMaxOrderIndex(for day: String) -> Int64 {
        let tasks = getTaskByDay(by: day) ?? []
        return tasks.map { $0.orderIndex }.max() ?? -1
    }
    
    func getAllTasks() -> [Task]{
        guard let context else { return []}
        
        var result: [Task]
        
        do {
            
            
            result = try context.fetch(Task.fetchRequest())
        } catch {
            print(error)
            return []
        }
        
        
        return result
    }
    
    func deleteTask(by id: UUID){
        
        guard let context, let taskToDelete = getTaskById(by: id) else { return }
        
        context.delete(taskToDelete)
        
        save()
        
    }
    
    func getTaskById(by id: UUID) -> Task? {
        guard let context else { return nil}
        
        do {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest() //pega a fetch
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString) //filtar pelo id
            return try context.fetch(fetchRequest).first //pega o primeiro
        } catch {
            print(error)
            return nil
        }
    }
    
    func getLastTask() -> Task? {
        guard let context else { return nil }
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "time", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print(error)
            return nil
        }
    }
    
    func getTaskByDay(by dayName: String) -> [Task]? {
        guard let context else { return nil}
        
        var result: [Task] = []
        
        do {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "dayOfTheWeek == %@", dayName)
            
            let sortDescriptor = NSSortDescriptor(key: "orderIndex", ascending: true) //na ordem do index
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            result = try context.fetch(fetchRequest)
            
        }catch {
            print(error)
        }
        
        return result
    }
    
    func updateTaskOrder(for day: String, newOrder: [Task]){
        
        for (index, task) in newOrder.enumerated() {
            task.orderIndex = Int64(index)
        }
        
        save()
    }
    
    func save() {
        if let context, context.hasChanges {
            do {
                try context.save()
                print("✅ Task salva com sucesso!")
            } catch {
                print("❌ Erro ao salvar: \(error)")
            }
        }
    }
}
