//
//  TaskManager.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 25/05/2025.
//

import Foundation

class TasksListManager : ObservableObject {
    @Published var items : [Task] = []
    
    init() {
        self.items = getTaskList()
    }
    
    private func refreshTaskList() {
        guard let data = try? JSONEncoder().encode(items) else {return}
        UserDefaults.standard.set(data, forKey: "notes")
    }
    func getTaskList() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: "notes") else {return []}
        if let json = try? JSONDecoder().decode([Task].self, from: data) {
            items = json
            return items
        }
        return []
    }
    
    func deleteTask(task : Task) {
        if let index = items.firstIndex(of: task) {
            items.remove(at: index)
            refreshTaskList()
        }
    }
    func toggleTask(task: Task) {
        if let index = items.firstIndex(of: task) {
            items[index].isCompleted.toggle()
            refreshTaskList()
        }
    }
    
    func updateTask(task: Task) {
        items.append(task)
        refreshTaskList()
    }
}
