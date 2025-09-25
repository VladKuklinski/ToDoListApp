//
//  TaskRepository.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 26/05/2025.
//

import Foundation

protocol TaskRepositoryProtocol {
    func getTaskList() -> [Task]
    func toggleTask(task: Task) -> [Task]
    func updateTask(task: Task) -> [Task]
    func deleteTask(task : Task) -> [Task]
    func getCurrentSelectedDateTasks(of date : Date) -> [Task]
}

class TaskRepository {
    private let taskDataProvider : TaskDataProvider
    
    init(taskDataProvider: TaskDataProvider) {
        self.taskDataProvider = taskDataProvider
    }

}

extension TaskRepository : TaskRepositoryProtocol {
    func getTaskList() -> [Task] { taskDataProvider.getTaskList() }
    
    func toggleTask(task: Task) -> [Task] { taskDataProvider.toggleTask(task: task) }
    
    func updateTask(task: Task) -> [Task] { taskDataProvider.updateTask(task: task) }
    
    func deleteTask(task: Task) -> [Task] { taskDataProvider.deleteTask(task: task) }
    
    func getCurrentSelectedDateTasks(of date: Date) -> [Task] { taskDataProvider.getCurrentSelectedDateTasks(of: date) }
    
    
}
