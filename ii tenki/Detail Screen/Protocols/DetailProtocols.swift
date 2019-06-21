//
//  DetailProtocols.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/21.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterDetailProtocol {
    var view: PresenterToViewDetailProtocol? {get set}
    var router:PresenterToRouterDetailProtocol? {get set}
    var interactor:PresenterToInteractorDetailProtocol? {get set}
    
    func fetchImage(url:String, imageView: UIImageView)
}

protocol InteractorToPresenterDetailProtocol {
    
}

protocol PresenterToViewDetailProtocol {
    
}

protocol PresenterToRouterDetailProtocol {
    static func createModule(data: [List],searchType: weatherSearchType) -> DetailViewController
}

protocol PresenterToInteractorDetailProtocol {
    var presenter: InteractorToPresenterDetailProtocol? {get set}
    func fetchImage(url:String, imageView:UIImageView)
}

