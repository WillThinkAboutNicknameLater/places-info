//
//  Weather.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 28.10.2021.
//

import Foundation

struct Weather: Codable {
    var details: Details
    
    struct Details: Codable {
        var temperature: Double
        var feelsLike: Double
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case feelsLike = "feels_like"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case details = "main"
    }
}
