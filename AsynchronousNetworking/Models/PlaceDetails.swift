//
//  PlaceDetails.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 03.11.2021.
//

import Foundation

struct PlaceDetails: Codable {
    var name: String
    var wikipediaUrl: String?
    var information: Information?
    
    struct Information: Codable {
        var description: String?
        
        enum CodingKeys: String, CodingKey {
            case description = "descr"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case wikipediaUrl = "wikipedia"
        case information = "info"
    }
}
