//
//  MainInteractor.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/19.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import ObjectMapper

class MainInteractor: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    
    func fetchWeatherData() {
        Alamofire.request(Constants.WebServices.ConstructedUrl).responseJSON { (response:DataResponse<Any>) in
            if response.response?.statusCode == 200 {
                if let json = response.value as AnyObject? {
                    let arrayValue = [json] as! NSArray
                    let arrayObject = Mapper<MainEntity>().mapArray(JSONArray: arrayValue as! [[String:Any]])
                    self.presenter?.weatherFechedSuccess(weatherArray: arrayObject)
                }
            } else {
                self.presenter?.weatherFetchFailed()
            }
        }
    }
    
    func fetchImage(url: String, imageView: UIImageView) {
        Alamofire.request(url).responseData { (response:DataResponse<Data>) in
            if response.error == nil {
                if let data = response.data {
                    imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
}
