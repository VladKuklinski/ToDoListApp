//
//  TaskHomePageViewModel.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 28/05/2025.
//

import Foundation

struct TaskHomePageConstants {
    
}

enum SliderTimeDirection {
    case past
    case future
    case unknown
}


protocol TaskHomePageViewModelInput {
    func selectTheDay(with date : Date)
    func onDateScrolled(to direction : SliderTimeDirection)
    
    func updateTask(task : Task)
    func toggleTaskCompletion(task: Task)
    func deleteTask(task: Task)
}

protocol TaskHomePageViewModelOutput {
    func getSelectedDate() -> Date
    func getCurrentSelectedDateTasks() -> [Task]
}

protocol TaskHomePageViewModelProtocol : ObservableObject, TaskHomePageViewModelInput, TaskHomePageViewModelOutput {
    
}

class TaskHomePageViewModel : TaskHomePageViewModelProtocol {
    
    private let taskUseCases : TaskUseCases
    private let dateUseCases : DateUseCases
    
    @Published var items : [Task] = []
    @Published var weeks: [WeekModel] = []
    @Published var selectedDate: Date {
        didSet {
            calcPastAndFutureWeeks(with: selectedDate)
        }
    }
    
    func calcPastAndFutureWeeks(with date : Date) {
        weeks = dateUseCases.calculatePastAndFutureWeeks(with: date)
    }
    
    init(taskUseCases: TaskUseCases, dateUseCases: DateUseCases, date: Date = Date()) {
        self.taskUseCases = taskUseCases
        self.dateUseCases = dateUseCases
        self.items = taskUseCases.getTaskList()
        self.selectedDate = Calendar.current.startOfDay(for: date)
        calcPastAndFutureWeeks(with: selectedDate)
    }
    
    
    
}

// input functions
extension TaskHomePageViewModel {
    func selectTheDay(with date: Date) {
        selectedDate = Calendar.current.startOfDay(for: date)
    }
    
    func onDateScrolled(to direction: SliderTimeDirection) {
        guard
            let prevWeekDay = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate),
            let nextWeekDay = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate)
        else {return}
        
        switch direction {
        case .past:
            selectedDate = prevWeekDay
        case .future:
            selectedDate = nextWeekDay
        case .unknown:
            return
        }
    }
    
    func updateTask(task: Task) {
        items = taskUseCases.updateTask(task: task)
    }
    
    func toggleTaskCompletion(task: Task) {
        items = taskUseCases.toggleTask(task: task)
    }
    
    func deleteTask(task: Task) {
        items = taskUseCases.deleteTask(task: task)
    }
}


// output functions
extension TaskHomePageViewModel {
    func getSelectedDate() -> Date {
        selectedDate
    }
    
    func getCurrentSelectedDateTasks() -> [Task] {
        taskUseCases.getCurrentSelectedDateTasks(of: selectedDate)
    }
}
