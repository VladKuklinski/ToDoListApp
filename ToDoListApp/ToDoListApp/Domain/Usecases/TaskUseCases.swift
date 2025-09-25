//
//  TaskUseCases.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 26/05/2025.
//

import Foundation

protocol TaskUseCasesProtocol {
    func getTaskList() -> [Task]
    func toggleTask(task: Task) -> [Task]
    func updateTask(task: Task) -> [Task]
    func deleteTask(task : Task) -> [Task]
    func getCurrentSelectedDateTasks(of date : Date) -> [Task]
}

class TaskUseCases {
    private let taskRepository : TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }

}

extension TaskUseCases : TaskUseCasesProtocol {
    func getTaskList() -> [Task] { taskRepository.getTaskList() }
    
    func toggleTask(task: Task) -> [Task] { taskRepository.toggleTask(task: task) }
    
    func updateTask(task: Task) -> [Task] { taskRepository.updateTask(task: task)}
    
    func deleteTask(task: Task) -> [Task] { taskRepository.deleteTask(task: task) }
    
    func getCurrentSelectedDateTasks(of date: Date) -> [Task] { taskRepository.getCurrentSelectedDateTasks(of: date) }
    
    
}
