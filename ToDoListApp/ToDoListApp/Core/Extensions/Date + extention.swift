//
//  DateExtension.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 18/05/2025.
//

import Foundation

extension Date {
    
    func monthToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        
        return formatter.string(from: self)
    }
    
    func toString(format : String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    var yesterday : Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self) ?? Date()
    }
    
    var tomorrow : Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self) ?? Date()
    }
    
}
