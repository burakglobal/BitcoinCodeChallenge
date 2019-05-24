//
//  HomeViewController.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: UIViewController,NVActivityIndicatorViewable {

    var presentor:HomePresenterProtocol?
    
    @IBOutlet weak var uiTableView: UITableView!
    var homeArrayList:Array<HomeModel> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startAnimating()
        
        presentor?.handleLocation(completition: { (res) in
            self.stopAnimating()
        })

        uiTableView.delegate = self
        uiTableView.dataSource = self
        self.largeTitle()
    }
}

extension HomeViewController:PresenterToViewProtocol{
    
    func showHome(homeArray: Array<HomeModel>) {
        self.homeArrayList = homeArray
        self.uiTableView.reloadData()
    }
    
    func showError() {
        self.presentAlert("Ooops", message: "Error loading the weather data")
    }
    
    
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        cell.city.text = homeArrayList[indexPath.row].cityName
        cell.temp.text = "\(homeArrayList[indexPath.row].tempString ?? "-- F")"
        cell.icon.image = homeArrayList[indexPath.row].weatherIcon

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentor?.showWeatherController(navigationController: self.navigationController!, weather: homeArrayList[indexPath.row])
    }
    
    
}

