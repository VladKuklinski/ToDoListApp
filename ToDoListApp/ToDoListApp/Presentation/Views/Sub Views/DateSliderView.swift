//
//  DateSliderView.swift
//  ToDoListApp
//
//  Created by Vlad Kuklinski on 18/05/2025.
//

import SwiftUI

struct DateSliderView<DateViewContent : View> : View {
    
    @ObservedObject var viewModel : TaskHomePageViewModel
    @State var direction : SliderTimeDirection = .unknown
    @State var activeTab = 1
    let dateViewContent : (_ week: WeekModel) -> DateViewContent
    
    
    init(viewModel : TaskHomePageViewModel, @ViewBuilder dateViewContent: @escaping (_: WeekModel) -> DateViewContent) {
        self.viewModel = viewModel
        self.dateViewContent = dateViewContent
    }
    
    var body: some View {
        TabView(selection: $activeTab) {
            dateViewContent(viewModel.weeks[0])
                .frame(maxWidth: .infinity)
                .tag(0)
            
            dateViewContent(viewModel.weeks[1])
                .frame(maxWidth: .infinity)
                .tag(1)
                .onDisappear {
                    guard direction != .unknown else {return}
                    viewModel.onDateScrolled(to: direction)
                    direction = .unknown
                    activeTab = 1
                }
            
            dateViewContent(viewModel.weeks[2])
                .frame(maxWidth: .infinity)
                .tag(2)

        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: activeTab) { _, newValue in
            if activeTab == 0 {
                direction = .past
            }
            if activeTab == 2 {
                direction = .future
            }
        }
        
    }
}


#Preview {
    
    ContentView(viewModel: TaskHomePageViewModel(taskUseCases: TaskUseCases(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())), dateUseCases: DateUseCases(dateRepository: DateRepository(dateDataProvider: DateDataProvider()))))

}


