//
//  MainRouter.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/19.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: PresenterToRouterProtocol {
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createModule() -> ViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "WeatherViewController") as! ViewController
        
        var presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MainPresenter()
        var interactor: PresenterToInteractorProtocol = MainInteractor()
        var router: PresenterToRouterProtocol = MainRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToDetailScreen(navigationController: UINavigationController, list: [List], searchType: weatherSearchType) {
        let detailModule = DetailRouter.createModule(data: list, searchType: searchType)
        navigationController.pushViewController(detailModule, animated: true)
    }
    
    
}
