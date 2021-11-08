//
//  TabContainerView.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 01.11.2021.
//

import SwiftUI

struct TabContainerView: View {
    @StateObject private var tabContainerViewModel = TabContainerViewModel()
    
    var tabItems: some View {
        VStack {
            ForEach(tabContainerViewModel.tabItemViewModels, id: \.self) { viewModel in
                if (viewModel.type == .settings) {
                    Spacer()
                }
                TabItemView(viewModel: viewModel, selectedTab: $tabContainerViewModel.selectedTab)
            }
        }
        .padding()
        .padding(.top, 35)
        .background(BlurView())
    }
    
    var body: some View {
        HStack (spacing: 0) {
            tabItems
            tabView(for: tabContainerViewModel.selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
        case .home:
            Text("Home")
        case .places:
            PlacesPageView()
        case .settings:
            Text("Settings")
        }
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
