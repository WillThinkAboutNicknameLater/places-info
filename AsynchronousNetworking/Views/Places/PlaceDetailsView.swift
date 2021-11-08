//
//  PlaceDetailsView.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 08.11.2021.
//

import SwiftUI

struct PlaceDetailsView: View {
    @StateObject var viewModel: PlaceDetailsViewModel
    
    var name: some View {
        Text(viewModel.details!.name)
            .font(.system(.largeTitle))
            .fontWeight(.semibold)
    }
    
    var information: some View {
        Text(viewModel.details!.information?.description ?? "There is no description")
            .font(.system(size: 12, weight: .regular))
    }
    
    var wikipedia: some View {
        Link(destination: URL(string: viewModel.details!.wikipediaUrl!)!, label: {
            Text("Wikipedia")
        })
    }
    
    var body: some View {
        VStack {
            if (viewModel.details != nil) {
                name
                    .padding()
                Spacer()
                
                information
                    .padding()
                Spacer()
                if (viewModel.details!.wikipediaUrl != nil) {
                    wikipedia
                        .padding()
                }
            }
        }
        .onAppear(perform: {
            viewModel.updatePlaceDetails()
        })
    }
}

struct PlaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
