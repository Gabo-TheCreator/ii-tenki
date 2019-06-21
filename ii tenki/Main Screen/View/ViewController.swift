//
//  ViewController.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/19.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var cityNameView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var searchCityView: UIView!
    @IBOutlet weak var searchCityImage: UIImageView!
    @IBOutlet weak var searchCityButton: UIButton!
    
    @IBOutlet weak var todaysWeatherView: UIView!
    @IBOutlet weak var todaysTimeLabel: UILabel!
    @IBOutlet weak var todaysWeatherLabel: UILabel!
    @IBOutlet weak var todaysMaxWeatherLabel: UILabel!
    @IBOutlet weak var todaysMinWeatherLabel: UILabel!
    @IBOutlet weak var todaysWeatherDescription: UILabel!
    @IBOutlet weak var todaysWeatherImage: UIImageView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var searchForCityViewContainer: UIView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var searchForCityButton: UIButton!
    @IBOutlet weak var searchButtonViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var errorMessageContainer: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: Variables
    
    var presenter: ViewToPresenterProtocol?
    var mainEntity : MainEntity?
    var values : [[List]] = [[]]
    var keyboardHeight : CGFloat = 0.0
    var baseTimeForAnimation : Double = 1.5
    var zeroTimeForAnimation : Double = 0.0
    
    // MARK: System functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hideSearchForCityViewContriner(duration: zeroTimeForAnimation)
        hideErrorMessage(duration: zeroTimeForAnimation)
        setUpDelegates()
        makeUrlBasedOnParameters(city: "Kyoto")
        presenter?.fetchWeather()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification,object: nil)
    }
    
    @objc func keyboardWillShow (_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.keyboardHeight = keyboardHeight
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                self.searchButtonView.transform = self.searchButtonView.transform.translatedBy(x: 0, y: -keyboardHeight)
            })
        }
    }

    // MARK: IBActions
    
    @IBAction func searchCity(_ sender: Any) {
        showSearchForCityViewContainer(duration: baseTimeForAnimation)
    }
    
    @IBAction func searchCityButtonConfirmation(_ sender: Any) {
        hideErrorMessage(duration: baseTimeForAnimation)
        if let cityStr = cityTextField.text {
            makeUrlBasedOnParameters(city: cityStr)
            presenter?.fetchWeather()
        }
    }
    
    @IBAction func openDetailForTodaysWeatherView(_ sender: Any) {
        openDetailViewController(data: values.first!, searchType: .closestInTime)
    }
    
    // MARK: Functions
    
    func openDetailViewController (data: [List], searchType: weatherSearchType) {
        presenter?.showDetailForSelectedDay(navigationController: navigationController!, list: data,searchType: searchType)
    }
    
    func showSearchForCityViewContainer(duration:Double) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .transitionCrossDissolve, animations: {
            self.view.bringSubviewToFront(self.searchForCityViewContainer)
            self.searchForCityViewContainer.alpha = 1
            self.cityTextField.becomeFirstResponder()
        })
    }
    
    func hideSearchForCityViewContriner(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .transitionCrossDissolve, animations: {
            self.searchForCityViewContainer.alpha = 0
            self.searchButtonView.transform = self.searchButtonView.transform.translatedBy(x: 0, y: self.keyboardHeight)
        })  { (_) in
            self.cityTextField.text = ""
            self.keyboardHeight = 0
            self.view.sendSubviewToBack(self.searchForCityViewContainer)
        }
    }
    
    func showErrorMessage (duration:Double) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .transitionFlipFromLeft, animations: {
            self.errorMessageContainer.alpha = 1
            self.errorMessageLabel.text = String(format: Constants.ApplicationMessages.errorMessageForSearch, self.cityTextField.text!)
            self.cityTextField.text = ""
        })
    }
    
    func hideErrorMessage (duration:Double) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .transitionFlipFromLeft, animations: {
            self.errorMessageContainer.alpha = 0
            self.errorMessageLabel.text = String(format: Constants.ApplicationMessages.errorMessageForSearch, " - ")
        })
    }
    
    func makeUrlBasedOnParameters (city: String) {
        Constants.WebServices.ConstructedUrl = Constants.WebServices.OpenWeatherMap_BaseUrl + Constants.WebServices.OpenWeatherMap_ApiVersion + Constants.WebServices.OpenWeatherMap_Forecast + Constants.WebServices.OpenWeatherMap_QueueCityReference + city.replacingOccurrences(of: " ", with: "%20") + Constants.WebServices.OpenWeatherMap_SeparatorInReference + Constants.WebServices.OpenWeatherMap_ApiKeyReference + Constants.WebServices.OpenWeatherMap_ApiKey
    }
    
    func setUpTodaysWeatherView (listOfValues: [[List]]) {
        
        if let item = listOfValues.first {
            if let list = item.first {
                if let main = list.main {
                    let temp = main.temp?.fromKelvinToCelsius() ?? 0.0
                    let tempMax = main.tempMax?.fromKelvinToCelsius() ?? 0.0
                    let tempMin = main.tempMin?.fromKelvinToCelsius() ?? 0.0
                    
                    todaysWeatherLabel.text = String(format: "%.1f°", temp)
                    todaysMaxWeatherLabel.text = String(format: "%.0f°", tempMax)
                    todaysMinWeatherLabel.text = String(format: "%.0f°", tempMin)
                }
                
                if let weather = list.weather?.first {
                    todaysWeatherDescription.text = weather.description ?? ""
                    presenter?.fetchImage(url: String(format: Constants.WebServices.OpenWeatherMap_Icon, weather.icon ?? ""), imageView: todaysWeatherImage)
                }
                
                if let dayTimeTxt = list.dtTxt {
                    var message = ""
                    let stringToDate = Utils.stringToDate(string: dayTimeTxt, format: Constants.DateFormaters.forecastFormatType)
                    let weatherYearMonthDay = Utils.dateToString(date: stringToDate, format: Constants.DateFormaters.yearMonthDay)
                    let now = Utils.dateToString(date: Date(), format: Constants.DateFormaters.yearMonthDay)
                    let hour = Utils.dateToString(date: stringToDate, format: Constants.DateFormaters.hourAndTimeFormat)
                    
                    if weatherYearMonthDay == now {
                        message = String(format: Constants.ApplicationMessages.todaysWeather, hour)
                    }
                    
                    todaysTimeLabel.text = message
                }
            }
        }
        
        if let dataResponse = mainEntity {
            if let city = dataResponse.city {
                cityNameLabel.text = city.name ?? ""
            }
        }
    }
    
    func filterWeatherResultsByDay (weatherData: MainEntity) {
        values.removeAll()

        if let list = weatherData.list {
            for item in list {
                
                let itemDate = Utils.stringToDate(string: item.dtTxt, format: Constants.DateFormaters.forecastFormatType)
                let now = Date()
                
                if itemDate > now {
                    if !values.isEmpty {
                        for position in 0..<values.count {
                            
                            let itemDate = Utils.stringToDate(string: item.dtTxt, format: Constants.DateFormaters.forecastFormatType)
                            let itemYMD = Utils.dateToString(date: itemDate, format: Constants.DateFormaters.yearMonthDay)
                            
                            let valuePosition = values[position][0]
                            let valueDate = Utils.stringToDate(string: valuePosition.dtTxt, format: Constants.DateFormaters.forecastFormatType)
                            let valueYMD = Utils.dateToString(date: valueDate, format: Constants.DateFormaters.yearMonthDay)
                            
                            if itemYMD == valueYMD {
                                values[position].append(item)
                            } else if position == values.count - 1 {
                                values.append([item])
                            }
                            
                            self.setUpTodaysWeatherView(listOfValues: values)
                            mainTableView.reloadData()
                        }
                    } else {
                        values = [[item]]
                    }
                }
            }
        }
    }
    
    func setUpDelegates () {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        cityTextField.delegate = self
    }
}

extension ViewController: PresenterToViewProtocol {
    
    func showWeather(weatherArray: Array<MainEntity>) {
        hideSearchForCityViewContriner(duration: baseTimeForAnimation)
        self.view.endEditing(true)
        
        if let weatherEntity = weatherArray.first {
            self.mainEntity = weatherEntity
            filterWeatherResultsByDay(weatherData: weatherEntity)
        }
    }
    
    func showError() {
        showErrorMessage(duration: baseTimeForAnimation)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicTypeCell") as! WeatherTableViewCell
        
        guard !values.isEmpty else {
            return cell
        }
        
        let middleValue = Int(values[indexPath.row + 1].count / 2)
        let index = values[indexPath.row + 1][middleValue]
        
        let indexDate = Utils.stringToDate(string: index.dtTxt, format: Constants.DateFormaters.forecastFormatType)
        let day = Utils.dateToString(date: indexDate, format: Constants.DateFormaters.fullDayName)
        cell.day.text = day
        
        
        if let main = index.main {
            if let tempMax = main.tempMax {
                cell.tempMax.text = String(format: "%.0f°", tempMax.fromKelvinToCelsius())
            }
            if let tempMin = main.tempMin {
                cell.tempMin.text = String(format: "%.0f°", tempMin.fromKelvinToCelsius())
            }
        }
        
        if let weather = index.weather?.first {
            if let icon = weather.icon {
                presenter?.fetchImage(url: String(format: Constants.WebServices.OpenWeatherMap_Icon, icon), imageView: cell.weatherImage)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailViewController(data: values[indexPath.row + 1], searchType: .middle)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchCityButtonConfirmation(searchForCityButton)
        return true
    }
    
}
