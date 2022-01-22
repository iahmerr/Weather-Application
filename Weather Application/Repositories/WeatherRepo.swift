//
//  WeatherRepo.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import Foundation
import CoreLocation

protocol WeatherRepositoryType {
    func getWeatherDetails(coordinates: CLLocation, completion: @escaping(Result<WeatherRequestResponse,AppError>)-> Void)
}

class WeatherRepository: WeatherRepositoryType {
    let service: WeatherServiceType = WeatherService()
    
    func getWeatherDetails(coordinates: CLLocation, completion: @escaping(Result<WeatherRequestResponse,AppError>)-> Void) {
        service.fetchWeather(for: coordinates, completion: completion)
    }
}
