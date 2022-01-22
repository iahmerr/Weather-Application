//
//  WeatherService.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import Foundation
import CoreLocation

protocol WeatherServiceType {
    func fetchWeather(for coordinates: CLLocation, completion: @escaping(Result<WeatherRequestResponse,AppError>) -> Void)
}

class WeatherService: WeatherServiceType {
    private let apiConvertible:ApiService = APIClient()
    
    func fetchWeather(for coordinates: CLLocation, completion: @escaping(Result<WeatherRequestResponse,AppError>) -> Void) {
        
        // Model for making request
        //  let request = WeatherServiceRequest(latitude: latitude, longitude: longitude)
        let request = coordinates
        let router = WeatherNetworkRouter.getWeather(request)
        apiConvertible.performRequest(router: router) { (result:Result<WeatherRequestResponse, AppError>) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
                
            }
        }
    }
}
