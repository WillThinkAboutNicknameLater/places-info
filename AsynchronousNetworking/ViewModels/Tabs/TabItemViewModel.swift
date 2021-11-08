//
//  TabItemViewModel.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 01.11.2021.
//

import Foundation

struct TabItemViewModel: Hashable {
    var imageName: String
    var title: String
    var type: TabItemType
    
    enum TabItemType {
        case home
        case places
        case settings
    }
}
