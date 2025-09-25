//
//  NewTaskView.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 26/05/2025.
//

import SwiftUI




struct NewTaskView : View {
    
    var selectedDate : Date
    var saveTask : (Task) -> ()
    
    @EnvironmentObject var items : TasksListManager
    @State var taskTitle : String = ""
    @State var taskDate : Date = .init()
    @Environment(\.dismiss) var  dismiss
    
    init(saveTask: @escaping (Task) -> Void, selectedDate: Date) {
        self._taskDate = State(initialValue: selectedDate)
        self.selectedDate = selectedDate
        self.saveTask = saveTask

    }
    
    var body: some View {
        VStack {
            Text("Adding new task")
                .fontDesign(.rounded)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background{
                    Rectangle()
                        .fill(.gray.opacity(0.27))
                        .clipShape(.rect(bottomLeadingRadius: 200, bottomTrailingRadius: 200))
                }
            VStack (spacing: 20){
                TextField("Your task title here...", text: $taskTitle)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.vertical)
                
                HStack(alignment: .center, spacing: 0){
                    Text("Choose a day:")
                        .font(.title3)
                    DatePicker("", selection: $taskDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                Button {
                    saveTask(Task(title: taskTitle, date: taskDate))
                    dismiss()
                } label: {
                    Text("Create a task")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.black))
                }

            }
            .padding(.horizontal)
            Spacer()

        }
        
    }
}

#Preview {
    NewTaskView(saveTask: { task in
        
    }, selectedDate: Date())
        .environmentObject(TasksListManager())
}
