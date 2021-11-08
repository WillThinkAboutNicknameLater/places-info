//
//  TabItemView.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 01.11.2021.
//

import SwiftUI

struct TabItemView: View {
    var viewModel: TabItemViewModel
    @Binding var selectedTab: TabItemViewModel.TabItemType
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = viewModel.type
            }
        }, label: {
            VStack {
                Image(systemName: viewModel.imageName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(selectedTab == viewModel.type ? .white : .gray)

                Text(viewModel.title)
                    .fontWeight(.semibold)
                    .font(.system(size: 11))
                    .foregroundColor(selectedTab == viewModel.type ? .white : .gray)
            }
            .padding(.vertical, 8)
            .frame(width: 70)
            .contentShape(Rectangle())
            .background(Color.primary.opacity(selectedTab == viewModel.type ? 0.15 : 0))
            .cornerRadius(10)
        })
            .buttonStyle(PlainButtonStyle())
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(viewModel: TabItemViewModel(imageName: "building.columns", title: "Places", type: .places), selectedTab: Binding<TabItemViewModel.TabItemType>.constant(.home))
    }
}
