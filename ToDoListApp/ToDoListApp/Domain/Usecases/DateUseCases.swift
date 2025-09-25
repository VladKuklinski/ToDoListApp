//
//  DateUseCases.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 26/05/2025.
//

import Foundation

protocol DateUseCasesProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel]
}

class DateUseCases {
    private let dateRepository : DateRepository
    init(dateRepository: DateRepository) {
        self.dateRepository = dateRepository
    }
}

extension DateUseCases : DateUseCasesProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel] {
        dateRepository.calculatePastAndFutureWeeks(with: date)
    }
}
