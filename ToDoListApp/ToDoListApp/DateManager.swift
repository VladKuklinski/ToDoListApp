//
//  DateManager.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 17/05/2025.
//

import Foundation

class DateManager : ObservableObject {
    
    @Published var weeks : [WeekModel] = []
    @Published var selectedDate : Date {
        didSet {
            calcWeek(with : selectedDate)
        }
    }
    
    init(with date : Date = Date()) {
        self.selectedDate = Calendar.current.startOfDay(for: date)
        calcWeek(with: selectedDate)
    }
    
    private func calcWeek(with date : Date) {
        
        guard
            let prevWeek = Calendar.current.date(byAdding: .day, value: -7, to: date),
            let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: date) else {
            return
        }
        
        
        weeks = [
            
            week(with: prevWeek, for: -1),
            week(with: date, for: 0),
            week(with: nextWeek, for: 1)
            
        ]
    }
    
    private func week(with date : Date, for index : Int) -> WeekModel {
        
        var allDays : [Date] = []
        
        guard let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else {
            return WeekModel(index: index, dates: allDays, referenceDate: date)
        }
        
        (0...6).forEach { day in
            if let weekDay = Calendar.current.date(byAdding: .day, value: day, to: startOfWeek) {
                allDays.append(weekDay)
            }
            
        }
        return WeekModel(index: index, dates: allDays, referenceDate: date)
    }
    
    func selectToday() {
        select(date: Date())
    }
    
    func select(date: Date) {
        selectedDate = Calendar.current.startOfDay(for: date)
    }
    
//        func update(to direction : SliderTimeDirection) {
//            guard
//                let prevWeekDay = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate),
//                let nextWeekDay = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate)
//    
//            else {
//                return
//            }
//    
//            switch direction {
//    
//            case .past:
//                selectedDate = prevWeekDay
//    
//            case .future:
//                selectedDate = nextWeekDay
//    
//            case .unknown:
//                selectedDate = selectedDate
//    
//            }
//            calcWeek(with: selectedDate)
//        }
    
    func update(to direction : SliderTimeDirection) {
        
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
    
}


    
    































// {
//    @Published var weeks : [WeekModel] = []
//    @Published var selectedDate : Date {
//        didSet {
//            calcWeek(with: selectedDate)
//        }
//    }
//    
//    init(with date : Date = Date()) {
//        self.selectedDate = Calendar.current.startOfDay(for: date)
//        calcWeek(with: selectedDate)
//    }
//    
//    private func calcWeek(with date : Date) {
//        weeks = [
//            week(for: Calendar.current.date(byAdding: .day, value: -7, to: date)!, with: -1),
//            week(for: date, with: 0),
//            week(for: Calendar.current.date(byAdding: .day, value: 7, to: date)!, with: 1)
//
//        ]
//    }
//    
//    private func week(for date: Date, with index: Int) -> WeekModel {
//        var result: [Date] = .init()
//        guard let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else {
//            return .init(index: index, dates: [], referenceDate: date)
//        }
//        
//        (0...6).forEach { day in
//            if let weekday = Calendar.current.date(byAdding: .day, value: day, to: startOfWeek) {
//                result.append(weekday)
//            }
//        }
//        return .init(index: index, dates: result, referenceDate: date)
//    }
//}
