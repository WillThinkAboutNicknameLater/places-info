//
//  Location.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 26.10.2021.
//

import Foundation

struct Location: Codable, Hashable {
    var point: Point
    var name: String
    var country: String
    var state: String?
    var city: String?
    var street: String?
    var houseNumber: String?
    var postCode: String?
    
    struct Point: Codable, Hashable {
        var latitude: Double
        var longitude: Double
        
        enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lng"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case point
        case name
        case country
        case state
        case city
        case street
        case houseNumber = "housenumber"
        case postCode = "postcode"
    }
}

struct Locations: Codable {
    var hits: [Location]
}
