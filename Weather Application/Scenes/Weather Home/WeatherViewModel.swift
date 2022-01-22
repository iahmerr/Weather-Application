//
//  WeatherViewModel.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import Foundation
import CoreLocation


class WeatherViewModel {
    
    var hourlyData: [WeatherRequestResponse.Hourly]?
    var daysData: [WeatherRequestResponse.Daily]?
    weak var delegate: PopulateData?
    private var respostry: WeatherRepositoryType
    private var currentCity = ""
    
    init() {
        self.respostry = WeatherRepository()
        self.currentCity = "rio de janeiro"
        self.fetchWeatherByCityName(searchedCityName: self.currentCity)
    }
    
    func fetchData(coordinates: CLLocation) {
        self.delegate?.showLoader(true)
        self.respostry.getWeatherDetails(coordinates: coordinates) {[weak self] result in
            self?.parseResponse(result: result)
        }
    }
    
    func parseResponse(result: Result<WeatherRequestResponse,AppError>) {
        switch result {
        case .failure(let error):
            print(error.localizedDescription)

        case .success( let model):
            self.hourlyData = model.hourly
            self.daysData = model.daily
            self.delegate?.refreshData()
        }
        self.delegate?.showLoader(false)
    }
    
    func getCellViewModel(index: Int)-> WeatherRequestResponse.Hourly? {
        guard let hourlyData = hourlyData else { return nil }
        return hourlyData[index]
    }
    
    func getHourlyCellCount()->Int {
        guard let hourlyData = hourlyData else { return 0 }
        return hourlyData.count
    }
    
    func getDaysCellViewModel(index: Int)-> WeatherRequestResponse.Daily? {
        guard let daysData = daysData else { return nil }
        return daysData[index]
    }
    
    func getDaysCellCount()->Int {
        guard let daysData = daysData else { return 0 }
        return daysData.count
    }
}
extension WeatherViewModel {
    
    func tabSelected(_ index: Int) {
        switch index {
            case 1:
            self.currentCity = "rio de janeiro"
            self.fetchWeatherByCityName(searchedCityName: self.currentCity)
            case 2:
            self.currentCity = "beijing"
            self.fetchWeatherByCityName(searchedCityName: self.currentCity)
            case 3:
            self.currentCity = "los angeles"
            self.fetchWeatherByCityName(searchedCityName: self.currentCity)
            default:
            print("lul")
        }
    }
    
    func fetchWeatherByCityName(searchedCityName: String) {
        if searchedCityName != "" {
            CLGeocoder().geocodeAddressString(searchedCityName) { (placemarks, error) in
                if let location = placemarks?.first?.location {
                    self.fetchData(coordinates: location)
                }
            }
        }
    }
}
protocol PopulateData: AnyObject {
    func refreshData()
    func showLoader(_ show: Bool)
}
