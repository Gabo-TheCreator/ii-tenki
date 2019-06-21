//
//  Utils.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/20.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension Double {
    func fromKelvinToCelsius() -> Double {
        return self - 273.15
    }
}

public class Utils {
    
    public static func stringToDate(string: String?, format: String) -> Date {
        if let dateString = string, dateString != "" {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            let result = formatter.date(from: dateString) ?? Date()
            
            return result
        } else {
            return Date()
        }
    }
    
    public static func dateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current //TimeZone.init(secondsFromGMT: -14400)
        let result = formatter.string(from: date)
        return result
    }

}
