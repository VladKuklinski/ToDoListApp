//
//  Task.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 25/05/2025.
//

import Foundation

struct Task : Hashable, Identifiable, Codable {
    var id : UUID
    var title : String
    var date : Date
    var isCompleted : Bool
    
    init(id: UUID = UUID(), title: String, date: Date, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}


