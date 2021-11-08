//
//  LocationDetailsView.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 06.11.2021.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    @ObservedObject var placesPageViewModel: PlacesPageViewModel
    
    var map: some View {
        Map(coordinateRegion:
                    .constant(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: placesPageViewModel.selectedLocation?.point.latitude ?? 0,
                            longitude: placesPageViewModel.selectedLocation?.point.longitude ?? 0
                        ), latitudinalMeters: 2500, longitudinalMeters: 2500
                    )), annotationItems: placesPageViewModel.places) { place in
                        MapPin(coordinate: CLLocationCoordinate2D(latitude: place.point.latitude, longitude: place.point.longitude), tint: place == placesPageViewModel.selectedPlace ? .red : .blue)
                    }
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var location: some View {
        LocationView(location: placesPageViewModel.selectedLocation!)
    }
    
    var weather: some View {
        VStack (spacing: 5) {
            HStack {
                Text("Temperature: " + String(format: "%.0f", placesPageViewModel.weather?.details.temperature ?? 0) + " ºC")
                Spacer()
            }
            HStack {
                Text("Feels like: " + String(format: "%.0f", placesPageViewModel.weather?.details.feelsLike ?? 0) + " ºC")
                Spacer()
            }
        }
    }
    
    var body: some View {
        VStack {
            map
                .padding()
            location
                .padding()
            weather
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct LocationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
