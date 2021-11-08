//
//  PlacesPageViewModel.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 02.11.2021.
//

import Foundation
import Combine

final class PlacesPageViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    
    private let locationService = LocationService()
    private let placeService = PlaceService()
    private let weatherService = WeatherService()
    
    @Published var locations: [Location] = []
    @Published var selectedLocation: Location?
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    @Published var weather: Weather?
    @Published var searchText = ""
    
    init() {
        $searchText
            .debounce(for: .milliseconds(250), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ string -> String? in
                if string.count < 1 {
                    self.locations = []
                    return nil
                }
                return string
            })
            .compactMap{ $0 }
            .sink(receiveValue: { [self] searchField in
                updateLocations(desiredLocation: searchField)
            })
            .store(in: &cancellables)
    }
    
    func updateData(location: Location) {
        locations = []
        selectedLocation = location
        Publishers.Zip(placeService.getPlaces(latitude: location.point.latitude, longitude: location.point.longitude), weatherService.getWeather(latitude: location.point.latitude, longitude: location.point.longitude))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { places, weather in
                self.places = places
                self.weather = weather
            })
            .store(in: &cancellables)
    }
    
    func updateLocations(desiredLocation: String) {
        locationService.getLocations(desiredLocation: desiredLocation)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { locations in
                self.locations = locations
                print(locations)
            })
            .store(in: &cancellables)
    }
    
}
