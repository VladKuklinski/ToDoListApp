//
//  TaskDataProvider.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 26/05/2025.
//

import Foundation

protocol TaskDataProviderProtocol {
    
    func getTaskList() -> [Task]
    func toggleTask(task: Task) -> [Task]
    func updateTask(task: Task) -> [Task]
    func deleteTask(task : Task) -> [Task]
    func getCurrentSelectedDateTasks(of date : Date) -> [Task]
}

class TaskDataProvider {
    private var taskList : [Task] = []
    
    init() {
        self.taskList = self.getTaskListFromUserDefaults()
    }
    
    private func getTaskListFromUserDefaults() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: "notes") else {return []}
        if let json = try? JSONDecoder().decode([Task].self, from: data) {
            return json
        }
        return []
    }
    
    private func saveUpdatedTaskList() {
        guard let data = try? JSONEncoder().encode(taskList) else {return}
        UserDefaults.standard.set(data, forKey: "notes")
    }
}

extension TaskDataProvider : TaskDataProviderProtocol {
    
    func getTaskList() -> [Task] {
        return taskList
    }
    
    func toggleTask(task: Task) -> [Task] {
        if let index = taskList.firstIndex(of: task) {
            taskList[index].isCompleted.toggle()
            saveUpdatedTaskList()
            return taskList
        }
        return[]

    }
    
    func updateTask(task: Task) -> [Task] {
        taskList.append(task)
        saveUpdatedTaskList()
        return taskList
    }
    
    func deleteTask(task: Task) -> [Task] {
        if let index = taskList.firstIndex(of: task) {
            taskList.remove(at: index)
            saveUpdatedTaskList()
            return taskList
        }
        return[]
    }
    
    func getCurrentSelectedDateTasks(of date: Date) -> [Task] {
        return taskList
            .filter{
                Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day)
            }
            .sorted {
                !$0.isCompleted && $1.isCompleted
            }
    }
    
    
}
