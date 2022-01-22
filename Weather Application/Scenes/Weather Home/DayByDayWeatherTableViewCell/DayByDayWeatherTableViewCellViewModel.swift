//
//  DayByDayWeatherTableViewCellViewModel.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 22/01/2022.
//

import Foundation

class DayByDayWeatherTableViewCellViewModel {
    
    var dailyData: WeatherRequestResponse.Daily?
    init(dayByDayData: WeatherRequestResponse.Daily?) {
        guard let dayData = dayByDayData else {return}
        self.dailyData = dayData
    }
    
    func bindData(completionHandler: @escaping (String,String, String, String, String) -> Void ) {
        guard let data = dailyData else { return }
        completionHandler("\(data.temp.min.roundedString(to: 0))°", "\(data.temp.max.roundedString(to: 0))°" ,"\(data.weather[0].description)", data.dt.dateOnly, data.weather[0].iconImage)
    }
}
