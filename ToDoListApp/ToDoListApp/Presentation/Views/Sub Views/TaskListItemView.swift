//
//  TaskListItem.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 25/05/2025.
//

import SwiftUI

struct TaskListItemView: View {
    
    var task : Task
    
    var onPress:(Task) -> ()
    var onLongPress:(Task) -> ()
    @State var showAlert = false

    
    var deleteAlert : Alert {
        Alert(title: Text("Hey!"), message: Text("Are you sure you want to delete this task?"), primaryButton: .destructive(Text("Delete"), action: deleteTask), secondaryButton: .cancel())
    }
    
    
    var body: some View {
        HStack ( spacing: 10) {
            Circle()
                .fill(task.isCompleted ? .green.opacity(0.5) : .blue.opacity(0.5))
                .frame(width: 20, height: 20)
            Text(task.title)
                .font(.system(size: 15, weight: .light))
                .padding(10)
                .background(task.isCompleted ? .green.opacity(0.4) : .blue.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            withAnimation {
                toggleTaskCompletion()
            }
        }
        .onLongPressGesture {
            showAlert = true
        }
        .alert(isPresented: $showAlert) {
            deleteAlert
        }
    }
    
    func toggleTaskCompletion() {
        onPress(task)
    }
    
    private func deleteTask() {
        onLongPress(task)
    }
}

#Preview {
    
    ContentView(viewModel: TaskHomePageViewModel(taskUseCases: TaskUseCases(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())), dateUseCases: DateUseCases(dateRepository: DateRepository(dateDataProvider: DateDataProvider()))))

}
