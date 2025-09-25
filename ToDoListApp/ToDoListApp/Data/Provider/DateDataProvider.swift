//
//  DateDataProvider.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 26/05/2025.
//

import Foundation

protocol DateDataProviderProtocol {
    func calculatePastAndFutureWeeks(with date : Date) -> [WeekModel]
}

class DateDataProvider {
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

}

extension DateDataProvider : DateDataProviderProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel] {
        guard
            let prevWeek = Calendar.current.date(byAdding: .day, value: -7, to: date),
            let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: date) else {
            return []
        }
        
        
        return [
            
            week(with: prevWeek, for: -1),
            week(with: date, for: 0),
            week(with: nextWeek, for: 1)
            
        ]
        
    }
    
    
}
