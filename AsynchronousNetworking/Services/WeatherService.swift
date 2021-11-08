//
//  WeatherService.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 26.10.2021.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func getWeather(latitude: Double, longitude: Double) -> AnyPublisher<Weather?, Never>
}

final class WeatherService: WeatherServiceProtocol {
    func getWeather(latitude: Double, longitude: Double) -> AnyPublisher<Weather?, Never> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: Keys.OPENWEATHERMAP_API_KEY)
        ]
        
        let url = components.url!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Weather?.self, decoder: JSONDecoder())
            .map { weather in
                guard var weather = weather else {
                    return nil
                }
                weather.details.temperature -= 273.15
                weather.details.feelsLike -= 273.15
                return weather
            }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
