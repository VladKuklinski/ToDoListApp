//
//  DateRepository.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 26/05/2025.
//

import Foundation

protocol DateRepositoryProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel]
}

class DateRepository {
    private let dateDataProvider : DateDataProvider
    
    init(dateDataProvider: DateDataProvider) {
        self.dateDataProvider = dateDataProvider
    }
}

extension DateRepository : DateRepositoryProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel] {
        dateDataProvider.calculatePastAndFutureWeeks(with: date)
    }
}
