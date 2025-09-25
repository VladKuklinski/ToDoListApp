//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 17/05/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var creatingNewTask = false
    
    @ObservedObject var viewModel : TaskHomePageViewModel

    
    var body: some View {
        ZStack {
            VStack {
                DateHeaderView(viewModel: viewModel)
                ScrollView(.vertical) {
                    TaskListView(viewModel: viewModel)
                }
                .scrollIndicators(.hidden)
            }
            .padding()
            .overlay(alignment: .bottomTrailing) {
                Button {
                    creatingNewTask.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 26))
                        .foregroundStyle(.white)
                        .padding(20)
                        .background(.black)
                        .clipShape(Circle())
                }
                .offset(x: -15)

            }
        }
        .sheet(isPresented: $creatingNewTask) {
            NewTaskView(saveTask: { task in
                viewModel.updateTask(task: task)
            }, selectedDate: viewModel.selectedDate)
            .presentationDetents([.fraction(0.5)])
        }
        
    }
}

#Preview {
    
    ContentView(viewModel: TaskHomePageViewModel(taskUseCases: TaskUseCases(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())), dateUseCases: DateUseCases(dateRepository: DateRepository(dateDataProvider: DateDataProvider()))))

}
