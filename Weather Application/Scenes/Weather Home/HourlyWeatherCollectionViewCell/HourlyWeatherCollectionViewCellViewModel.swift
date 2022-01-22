//
//  HourlyWeatherCollectionViewCellViewModel.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import Foundation


class HourlyWeatherCollectionViewCellViewModel {
 
    var hourlyData: WeatherRequestResponse.Hourly?
    
    init(hourlyData: WeatherRequestResponse.Hourly?) {
        guard let currentHour = hourlyData else {return}
        self.hourlyData = currentHour
    }
    
    func bindData(completionHandler: @escaping (String, String, String, String) -> Void ) {
        guard let data = hourlyData else { return }
        completionHandler("\(data.temp.roundedString(to: 0))°", "\(data.humidity)%", data.dt.dayDateMonth, data.weather[0].iconImage)
    }
}
