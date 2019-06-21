//
//  Constants.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/19.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation

//MARK: Constants
//This class stores the constants definitions for the correct behavior of the app

public class Constants: NSObject {
    
    public struct WebServices {
        //"api.openweathermap.org/data/2.5/weather?q=%@&appid=%@"
        public static let OpenWeatherMap_BaseUrl = "http://api.openweathermap.org/data/"
        public static let OpenWeatherMap_ApiVersion = "2.5/"
        public static let OpenWeatherMap_Weather = "weather?" //current time
        public static let OpenWeatherMap_Forecast = "forecast?" // 5 days
        public static let OpenWeatherMap_QueueCityReference = "q="
        public static let OpenWeatherMap_QueueByZipCodeReference = "zip="
        public static let OpenWeatherMap_ApiKeyReference = "appid="
        public static let OpenWeatherMap_SeparatorInReference = "&"
        public static let OpenWeatherMap_ApiKey = "72cffb80a25b647028b7a5b8d1a5e49b"
        public static let OpenWeatherMap_Icon = "http://openweathermap.org/img/w/%@.png"
        
        public static var ConstructedUrl = ""
    }
    
    public struct DateFormaters {
        public static let forecastFormatType = "yyyy-MM-dd H:mm:ss"
        public static let yearMonthDay = "yyyyMMdd"
        public static let simpleDay = "d"
        public static let hourAndTimeFormat = "ha"
        public static let TwentyFourHourFormat = "H"
        public static let fullDayName = "EEEE"
    }
    
    public struct ApplicationMessages {
        public static let todaysWeather = "Weather for Today, at %@"
        public static let errorMessageForSearch = "Ops... Looks like I wasn't avaliable to find the city \"%@\". Please check the spelling and spaces, and try again."
    }
}

enum weatherSearchType {
    case middle
    case closestInTime
}
