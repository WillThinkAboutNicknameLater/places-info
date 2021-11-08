//
//  TabContainerViewModel.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 01.11.2021.
//

import Foundation

final class TabContainerViewModel: ObservableObject {
    @Published var selectedTab: TabItemViewModel.TabItemType = .home
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "house", title: "Home", type: .home),
        TabItemViewModel(imageName: "building.columns", title: "Places", type: .places),
        TabItemViewModel(imageName: "gear", title: "Settings", type: .settings)
    ]
}
