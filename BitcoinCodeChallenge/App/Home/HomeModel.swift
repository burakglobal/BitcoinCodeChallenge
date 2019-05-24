//
//  HomeModel.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import UIKit

class HomeModel:NSObject {

    var cityName:String
    var latitude:Double
    var longitude:Double
    var weatherIcon:UIImage?
    var temperture:Double? {
        didSet {
            let mf = MeasurementFormatter()
            mf.numberFormatter.maximumFractionDigits = 0
            mf.numberFormatter.numberStyle = .none
            let t = Measurement(value: self.temperture!, unit: UnitTemperature.kelvin)
            let fahr = mf.string(from: t)
            self.tempString = "\(fahr)"
        }
    }
    
    var tempString:String?
    
    init(cityName:String, latitude:Double, longitude:Double) {
        self.cityName = cityName
        self.latitude = latitude
        self.longitude = longitude
    }

    public class func modelsFromDictionaryArray() -> [HomeModel] {
        var models: [HomeModel] = []
        let citiesDic = [("Tokyo", "JP", 35.683333, 139.683333),
                         ("London", "UK", 51.509865, -0.118092),
                         ("Delhi", "IN", 28.61, 77.23),
                         ("Manila", "PH", 14.58, 121),
                         ("São Paulo", "BR", -23.55, -46.633333)]

        for city in citiesDic {
            models.append(HomeModel(cityName: city.0, latitude: city.2, longitude: city.3))
        }

        return models
    }
}

