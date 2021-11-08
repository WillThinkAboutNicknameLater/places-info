//
//  Place.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 26.10.2021.
//

import Foundation

struct Place: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var point: Point
    
    struct Point: Codable, Hashable {
        var latitude: Double
        var longitude: Double
        
        enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "xid"
        case name
        case point
    }
}
