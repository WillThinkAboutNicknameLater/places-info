//
//  PlacesPageView.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 02.11.2021.
//

import SwiftUI

struct PlacesPageView: View {
    @StateObject var placesPageViewModel = PlacesPageViewModel()
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search location", text: $placesPageViewModel.searchText)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.primary.opacity(0.15))
        .cornerRadius(10)
    }
    
    var listOfLocations: some View {
        ScrollView {
            LazyVStack (spacing: 10) {
                ForEach(placesPageViewModel.locations, id: \.self) { location in
                    Button(action: {
                        placesPageViewModel.updateData(location: location)
                    }, label: {
                        LocationView(location: location)
                            .lineLimit(1)
                            .padding(5)
                    })
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            .background(BlurView())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
    
    var listOfPlaces: some View {
        List (selection: $placesPageViewModel.selectedPlace) {
            Section (content: {
                ForEach(placesPageViewModel.places, id: \.self) { place in
                    NavigationLink(destination: {
                        PlaceDetailsView(viewModel: PlaceDetailsViewModel(placeId: place.id))
                    }, label: {
                        PlaceView(place: place)
                    })
                }
            }, header: {
                Text("Places")
            })
        }
        .listStyle(SidebarListStyle())
        .padding(.vertical)
    }
    
    var locationDetails: some View {
        LocationDetailsView(placesPageViewModel: placesPageViewModel)
            .frame(width: 350)
            .background(BlurView())
    }
    
    var body: some View {
        HStack (spacing: 0) {
            NavigationView {
                VStack (spacing: 0) {
                    searchBar
                        .padding(.horizontal)
                        .padding(.top)
                    ZStack {
                        if (placesPageViewModel.places.count > 0) {
                            listOfPlaces
                        } else {
                            VStack {
                                Spacer()
                                Text("There are no places")
                                Spacer()
                            }
                        }
                        
                        if (placesPageViewModel.locations.count > 0) {
                            listOfLocations
                        }
                    }
                }
            }
            
            Divider()
            
            if (placesPageViewModel.selectedLocation != nil) {
                locationDetails
            }
        }
    }
}

struct PlacesPageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
