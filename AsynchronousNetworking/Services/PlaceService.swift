//
//  PlaceService.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 26.10.2021.
//

import Foundation
import Combine

protocol PlaceServiceProtocol {
    func getPlaces(latitude: Double, longitude: Double, radius: Int) -> AnyPublisher<[Place], Never>
    func getPlaceDetails(placeId: String) -> AnyPublisher<PlaceDetails?, Never>
}

final class PlaceService: PlaceServiceProtocol {
    func getPlaces(latitude: Double, longitude: Double, radius: Int = 1000) -> AnyPublisher<[Place], Never> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.opentripmap.com"
        components.path = "/0.1/ru/places/radius"
        components.queryItems = [
            URLQueryItem(name: "radius", value: String(radius)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "apikey", value: Keys.OPENTRIPMAP_API_KEY)
        ]
        
        let url = components.url!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Place].self, decoder: JSONDecoder())
            .map { $0.filter { !$0.name.isEmpty } }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getPlaceDetails(placeId: String) -> AnyPublisher<PlaceDetails?, Never> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.opentripmap.com"
        components.path = "/0.1/ru/places/xid/\(placeId)"
        components.queryItems = [
            URLQueryItem(name: "apikey", value: Keys.OPENTRIPMAP_API_KEY)
        ]
        
        let url = components.url!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PlaceDetails?.self, decoder: JSONDecoder())
            .map { details in
                guard var details = details else {
                    return nil
                }
                let detailsDescription = details.information?.description?.decodeFromHTML()
                details.information?.description = detailsDescription
                return details
            }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
