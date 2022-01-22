//
//  WeatherNetworkRouter.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import Foundation
import CoreLocation

struct ProductionServer {
    static var ApiKey = "92aa6553a6383408837982297b6a870b"
}

public protocol URLRequestConvertible {
    func urlRequest()  -> URLRequest?
}
enum WeatherNetworkRouter<T>: URLRequestConvertible {
    
    case getWeather(T)
    
    private var params: CLLocation {
        switch self {
        case .getWeather(let params):
             let request = params as! CLLocation
           return request
        }
    }
    
    private var method: String {
        switch self {
        case .getWeather:
            return "GET"
        }
    }

    func urlRequest() -> URLRequest? {
    
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(params.coordinate.latitude)&lon=\(params.coordinate.longitude)&exclude=minutely,alerts&appid=\(ProductionServer.ApiKey)&units=metric") else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method
        
        return urlRequest
    }
}
