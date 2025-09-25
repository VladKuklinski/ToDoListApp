//
//  DataHeaderView.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 17/05/2025.
//

import SwiftUI

struct DateHeaderView: View {
    
    @ObservedObject var viewModel : TaskHomePageViewModel
    
    let currentMonthName = DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1]

    var body: some View {
        ZStack {
            
            VStack {
                
                header()
                DateSliderView(viewModel: viewModel) { week in
                    DateView(viewModel: viewModel, week: week)
                }
                .frame(height: 60, alignment: .top)
                Divider()
                Text(viewModel.selectedDate.toString(format: "EEEE, dd.MM.yyyy"))
                    .padding(.trailing, 10)
                    .foregroundStyle(.gray)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        
        }
    }
    
    private var greetingText : String {
        if viewModel.selectedDate == Calendar.current.startOfDay(for: Date()) {
            return "What's up for today?"
        } else if viewModel.selectedDate < Calendar.current.startOfDay(for: Date()) {
            
            return "Wanna see your past?"
            
        } else {
            return "Planning for future?"
        }
    }
    
    private func header() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Hi there!")
                    .fontWeight(.black)
                    .font(.title2)
                Text(greetingText)

                
                    .foregroundStyle(.gray)
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                Text(viewModel.selectedDate.monthToString())
                Button {
                    
                    viewModel.selectTheDay(with: Date())
                   
                } label: {
                    Text("Back to today")
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(PlainButtonStyle())

            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    
    ContentView(viewModel: TaskHomePageViewModel(taskUseCases: TaskUseCases(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())), dateUseCases: DateUseCases(dateRepository: DateRepository(dateDataProvider: DateDataProvider()))))

}
