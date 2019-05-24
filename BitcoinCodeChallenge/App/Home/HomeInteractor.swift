//
//  HomeViewController.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import PromiseKit
import CoreLocation

class HomeInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    var weatherArr = HomeModel.modelsFromDictionaryArray()
    let locationHelper = LocationHelper()

    private let appID = "38b0d89b4979dbd20ff64146a4708232"
  
    struct WeatherInfo: Codable {
        let main: Temperature
        let weather: [Weather]
        var name: String = "Error: invalid jsonDictionary! Verify your appID is correct"
    }

    struct Weather: Codable {
        let icon: String
        let description: String
    }

    struct Temperature: Codable {
        let temp: Double
    }

    func handleLocation(completition:@escaping(_ res:Bool) ->()) {
        self.updateWithCurrentLocation { (res) in
            self.fetchCities(completition: { (res) in
                completition(true)
            })
        }
    }

    func fetchCities(completition:@escaping(_ res:Bool) ->()) {
        process { (res,dat) in
            if res {
                if let dat = dat {
                    self.presenter?.homeFetchedSuccess(homeModelArray: dat)
                    completition(true)
                    return
                }
            }
            completition(false)
            self.presenter?.homeFetchFailed()
        }
    }

    func process(completition:@escaping(_ result:Bool, _ dat:[HomeModel]?)->()) {

        let queueTracker = DispatchGroup()

            for city in weatherArr {
                queueTracker.enter()

                self.getWeather(atLatitude: city.latitude,
                                longitude: city.longitude)
                    .then { [weak self] weatherInfo -> Promise<UIImage> in
                        guard let self = self else { return brokenPromise()

                        }
                        city.temperture = weatherInfo.main.temp
                        return self.getIcon(named: weatherInfo.weather.first!.icon)
                    }
                    .done(on: DispatchQueue.main) { icon in
                        queueTracker.leave()
                        city.weatherIcon = icon
                    }
                    .catch { error in
                        completition(false, nil)
                    }
                    .finally {
                }
            }

            queueTracker.notify(queue: .main) { 
                completition(true, self.weatherArr)
            }

    }

    func getWeather(atLatitude latitude: Double, longitude: Double) -> Promise<WeatherInfo> {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=" +
        "\(latitude)&lon=\(longitude)&appid=\(appID)"
        let url = URL(string: urlString)!

        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                return try JSONDecoder().decode(WeatherInfo.self, from: $0.data)
        }
    }

    func getIcon(named iconName: String) -> Promise<UIImage> {
        return Promise<UIImage> {
            getFile(named: iconName, completion: $0.resolve)
            }
            .recover { _ in
                self.getIconFromNetwork(named: iconName)
        }
    }

    func getIconFromNetwork(named iconName: String) -> Promise<UIImage> {
        let urlString = "http://openweathermap.org/img/w/\(iconName).png"
        let url = URL(string: urlString)!

        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
            }
            .then(on: DispatchQueue.global(qos: .background)) { urlResponse in
                return Promise {
                    self.saveFile(named: iconName, data: urlResponse.data, completion: $0.resolve)
                    }
                    .then(on: DispatchQueue.global(qos: .background)) {
                        return Promise.value(UIImage(data: urlResponse.data)!)
                }
        }
    }


    private func saveFile(named: String, data: Data, completion: @escaping (Error?) -> Void) {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(named+".png") else { return }

        DispatchQueue.global(qos: .background).async {
            do {
                try data.write(to: path)
                print("Saved image to: " + path.absoluteString)
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }

    private func getFile(named: String, completion: @escaping (UIImage?, Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(named+".png"),
                let data = try? Data(contentsOf: path),
                let image = UIImage(data: data) {
                DispatchQueue.main.async { completion(image, nil) }
            } else {
                let error = NSError(domain: "WeatherOrNot",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Image file '\(named)' not found."])
                DispatchQueue.main.async { completion(nil, error) }
            }
        }
    }

    private func updateWithCurrentLocation(completition:@escaping(_ res:Bool) ->()) {
        locationHelper.getLocation()
            .done { [weak self] placemark in
                self?.weatherArr.insert(HomeModel(cityName: placemark.name ?? "--", latitude: placemark.location?.coordinate.latitude ?? 0.0, longitude: placemark.location?.coordinate.longitude ?? 0.0), at: 0)
                completition(true)
            }
            .catch { error in

                completition(false)

                switch error {
                case is CLError where (error as? CLError)?.code == .denied: break


                default:
                    break;
                }
        }
    }
}
