//
//  DateView.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 18/05/2025.
//

import SwiftUI

struct DateView: View {
    
    @ObservedObject var viewModel : TaskHomePageViewModel
    var week : WeekModel
    
    var body: some View {
        
        HStack {
            ForEach(0..<7) { day in
                
                VStack {
                    Text(week.dates[day].toString(format: "EEE").uppercased())
                        .frame(maxWidth: .infinity)
                        .fontWeight(week.referenceDate == week.dates[day] ? .semibold : .light)
                        .font(.system(size: 12))
                        .foregroundStyle(week.referenceDate == week.dates[day] ? .white : .gray)
                    
                    Spacer()
                        .frame(height: 4)
                    
                    Text(week.dates[day].toString(format: "d"))
                        .frame(maxWidth: .infinity)
                        .fontWeight(week.referenceDate == week.dates[day] ? .bold : .light)

                        .font(.system(size: 16))
                        .foregroundStyle(week.referenceDate == week.dates[day] ? .white : .black)
                }
                .frame(maxWidth: .infinity)
                .padding(4)
                .background(week.referenceDate == week.dates[day] ? .black : .clear)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                .onTapGesture {
                    withAnimation(.linear(duration: 0.02)) {
                        viewModel.selectTheDay(with: week.dates[day])

                    }
                }
            }
        }
    }
}

#Preview {
    
    ContentView(viewModel: TaskHomePageViewModel(taskUseCases: TaskUseCases(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())), dateUseCases: DateUseCases(dateRepository: DateRepository(dateDataProvider: DateDataProvider()))))

}

