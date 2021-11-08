//
//  ContentView.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 26.10.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabContainerView()
            .ignoresSafeArea(.all, edges: .all)
            .frame(width: NSScreen.main!.visibleFrame.width / 1.1, height: NSScreen.main!.visibleFrame.height - 60)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
