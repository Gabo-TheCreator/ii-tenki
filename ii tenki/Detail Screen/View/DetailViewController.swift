//
//  DetailViewController.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/21.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    //MARK: IBOutlets
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var iconTemperature: UIImageView!
    
    @IBOutlet weak var hourlyTemperatureCollectionView: UICollectionView!
    
    @IBOutlet weak var detailWeatherMain: UILabel!
    @IBOutlet weak var detailClouds: UILabel!
    @IBOutlet weak var detailWind: UILabel!
    @IBOutlet weak var detailHumidity: UILabel!
    
    
    //MARK: Variables
    
    var presenter: ViewToPresenterDetailProtocol?
    var lists : [List] = []
    var nextWeatherReport : List?
    var searchType : weatherSearchType = .middle
    
    //MARK: System Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        searchForNextWeatherReport()
        setUpDelegates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupNavigationBar () {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func searchForNextWeatherReport () {
        
        switch searchType {
            
        case .middle:
            let middleIndex = Int(lists.count / 2)
            nextWeatherReport = lists[middleIndex]
            loadWeatherData()
            
        case .closestInTime:
            for list in lists {
                let listTime = Utils.stringToDate(string: list.dtTxt, format: Constants.DateFormaters.forecastFormatType)
                let timeNow = Date()
                
                if listTime > timeNow {
                    nextWeatherReport = list
                    loadWeatherData()
                    break
                }
            }
        }
        
    }
    
    func loadWeatherData () {
        
        if let nextWeatherValue = nextWeatherReport {
            if let main = nextWeatherValue.main {
                
                let temp = main.temp?.fromKelvinToCelsius() ?? 0.0
                let tempMax = main.tempMax?.fromKelvinToCelsius() ?? 0.0
                let tempMin = main.tempMin?.fromKelvinToCelsius() ?? 0.0
                let humidity = main.humidity ?? 0.0
                
                temperature.text = String(format: "%.1f°", temp)
                maxTemperature.text = String(format: "%.1f°", tempMax)
                minTemperature.text = String(format: "%.1f°", tempMin)
                detailHumidity.text = String(format: "%.0f", humidity) + "%"
            }
            
            if let weather = nextWeatherValue.weather?.first {
                detailWeatherMain.text = "\(weather.main ?? "")"
                let icon = weather.icon ?? ""
                presenter?.fetchImage(url: String(format: Constants.WebServices.OpenWeatherMap_Icon, icon), imageView: iconTemperature)
            }
            
            if let clouds = nextWeatherValue.clouds {
                detailClouds.text = "\(clouds.all ?? 0)%"
            }
            
            if let wind = nextWeatherValue.wind {
                detailWind.text = "\(wind.speed ?? 0.0)m/s"
            }
        }
    }
    
    func setUpDelegates () {
        hourlyTemperatureCollectionView.dataSource = self
        hourlyTemperatureCollectionView.delegate = self
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyWeatherIdentifier", for: indexPath) as! hourlyWeatherCollectionViewCell
        
        let itemIndex = lists[indexPath.row]
        let temperature = itemIndex.main?.temp?.fromKelvinToCelsius() ?? 0.0
        let itemDate = Utils.stringToDate(string: itemIndex.dtTxt, format: Constants.DateFormaters.forecastFormatType)
        let hourAndTimeformat = Utils.dateToString(date: itemDate, format: Constants.DateFormaters.hourAndTimeFormat)
        cell.weatherTemperatureAndHour.text = "\(String(format: "%.1f°", temperature)) - \(hourAndTimeformat)"
        
        let icon = itemIndex.weather?.first?.icon ?? ""
        presenter?.fetchImage(url: String(format: Constants.WebServices.OpenWeatherMap_Icon, icon), imageView: cell.weatherIcon)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nextWeatherReport = lists[indexPath.row]
        loadWeatherData()
    }
    
}

extension DetailViewController: PresenterToViewDetailProtocol {
    
}
