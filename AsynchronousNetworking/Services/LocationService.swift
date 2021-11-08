//
//  LocationService.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 26.10.2021.
//

import Foundation
import Combine

protocol LocationServiceProtocol {
    func getLocations(desiredLocation: String) -> AnyPublisher<[Location], Never>
}

final class LocationService: LocationServiceProtocol {
    func getLocations(desiredLocation: String) -> AnyPublisher<[Location], Never> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "graphhopper.com"
        components.path = "/api/1/geocode"
        components.queryItems = [
            URLQueryItem(name: "q", value: desiredLocation),
            URLQueryItem(name: "key", value: Keys.GRAPHHOPPER_API_KEY)
        ]
        
        let url = components.url!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Locations.self, decoder: JSONDecoder())
            .map { Array(Set($0.hits)) }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
