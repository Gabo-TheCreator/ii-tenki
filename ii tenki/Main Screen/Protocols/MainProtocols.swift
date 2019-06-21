//
//  MainProtocols.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/20.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol {
    var view: PresenterToViewProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    func fetchWeather()
    func showDetailForSelectedDay(navigationController:UINavigationController, list: [List], searchType: weatherSearchType)
    func fetchImage(url:String, imageView: UIImageView)
}

protocol PresenterToViewProtocol {
    func showWeather(weatherArray:Array<MainEntity>)
    func showError()
}

protocol PresenterToRouterProtocol {
    static func createModule() -> ViewController
    func pushToDetailScreen(navigationController:UINavigationController, list: [List], searchType: weatherSearchType)
}

protocol PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetchWeatherData()
    func fetchImage(url:String, imageView: UIImageView)
}

protocol InteractorToPresenterProtocol {
    func weatherFechedSuccess(weatherArray:Array<MainEntity>)
    func weatherFetchFailed()
}
