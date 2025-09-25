//
//  TaskListView.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 25/05/2025.
//

import SwiftUI

struct TaskListView : View {
    
    @ObservedObject var viewModel : TaskHomePageViewModel
    var currentDateTasks : [Task] = []
    
    init(viewModel : TaskHomePageViewModel) {
        self.viewModel = viewModel
        currentDateTasks = viewModel.getCurrentSelectedDateTasks()
    }
    
    var body: some View {
        VStack {
            ForEach(currentDateTasks) { task in
                TaskListItemView(task: task, onPress: { task in
                    toggleTaskCompletion(task: task)
                },
            onLongPress: { task in
                    deleteTask(task: task)
                })
                
                
                    .background(alignment: .leading) {
                        if currentDateTasks.last?.id != task.id {
                            Rectangle()
                                .fill(task.isCompleted ? .green.opacity(0.4) : .blue.opacity(0.4))
                                .frame(width: 1, height: 25)
                                .offset(x: 9.4, y: 23)
                                
                        }
                    }
            }
        }
        .padding()
    }
    
    func toggleTaskCompletion(task : Task) {
        viewModel.toggleTaskCompletion(task: task)
    }
    func deleteTask(task: Task) {
        viewModel.deleteTask(task: task)
    }
}

#Preview {
    
    ContentView(viewModel: TaskHomePageViewModel(taskUseCases: TaskUseCases(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())), dateUseCases: DateUseCases(dateRepository: DateRepository(dateDataProvider: DateDataProvider()))))

}
