//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 17/05/2025.
//

import SwiftUI

@main
struct ToDoListAppApp: App {
    
   
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: TaskHomePageViewModel(
                    taskUseCases: TaskUseCases(
                        taskRepository: TaskRepository(
                            taskDataProvider: TaskDataProvider())),
                    dateUseCases: DateUseCases(
                        dateRepository: DateRepository(
                            dateDataProvider: DateDataProvider()))))

        }
    }
}
