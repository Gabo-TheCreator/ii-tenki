//
//  MainEntity.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/19.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import ObjectMapper

class MainEntity: Mappable {
    var cod: String?
    var message: Double?
    var cnt: Int?
    var list: [List]?
    var city: City?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        cod <- map[Constants.forecastEntity.cod]
        message <- map[Constants.forecastEntity.message]
        cnt <- map[Constants.forecastEntity.cnt]
        list <- map[Constants.forecastEntity.list.list]
        city <- map[Constants.forecastEntity.city.city]
    }
}

class List: Mappable {
    
    var dt: Int?
    var main: Main?
    var weather: [Weather]?
    var clouds: Clouds?
    var wind: Wind?
    var rain: Rain?
    var sys: Sys?
    var dtTxt: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        dt <- map[Constants.forecastEntity.list.dt]
        main <- map[Constants.forecastEntity.list.main.main]
        weather <- map[Constants.forecastEntity.list.weather.weather]
        clouds <- map[Constants.forecastEntity.list.clouds.clouds]
        wind <- map[Constants.forecastEntity.list.wind.wind]
        rain <- map[Constants.forecastEntity.list.rain.rain]
        sys <- map[Constants.forecastEntity.list.sys.sys]
        dtTxt <- map[Constants.forecastEntity.list.dt_txt]
    }
}

class Main: Mappable {
    
    var temp : Double?
    var tempMin : Double?
    var tempMax : Double?
    var pressure : Double?
    var seaLevel : Double?
    var grndLevel : Double?
    var humidity : Double?
    var tempKf : Double?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        temp <- map[Constants.forecastEntity.list.main.temp]
        tempMin <- map[Constants.forecastEntity.list.main.temp_min]
        tempMax <- map[Constants.forecastEntity.list.main.temp_max]
        pressure <- map[Constants.forecastEntity.list.main.pressure]
        seaLevel <- map[Constants.forecastEntity.list.main.sea_level]
        grndLevel <- map[Constants.forecastEntity.list.main.grnd_level]
        humidity <- map[Constants.forecastEntity.list.main.humidity]
        tempKf <- map[Constants.forecastEntity.list.main.temp_kf]
    }
}

class Weather: Mappable {
    
    var id : Int?
    var main : String?
    var description : String?
    var icon : String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map[Constants.forecastEntity.list.weather.id]
        main <- map[Constants.forecastEntity.list.weather.main]
        description <- map[Constants.forecastEntity.list.weather.description]
        icon <- map[Constants.forecastEntity.list.weather.icon]
    }
}

class Clouds: Mappable {
    
    var all : Int?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        all <- map[Constants.forecastEntity.list.clouds.all]
    }
}

class Wind: Mappable {
    
    var speed : Double?
    var deg : Double?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        speed <- map[Constants.forecastEntity.list.wind.speed]
        deg <- map[Constants.forecastEntity.list.wind.deg]
    }
    
}

class Rain: Mappable {
    
    var treeH : Double?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        treeH <- map[Constants.forecastEntity.list.rain.treeH]
    }
    
}

class Sys: Mappable {
    
    var pod : String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        pod <- map[Constants.forecastEntity.list.sys.pod]
    }

}

class City: Mappable {
    
    var id : Int?
    var name : String?
    var coord : Coord?
    var country : String?
    var population : Int?
    var timezone : Int?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map[Constants.forecastEntity.city.id]
        name <- map[Constants.forecastEntity.city.name]
        coord <- map[Constants.forecastEntity.city.coord.coord]
        country <- map[Constants.forecastEntity.city.country]
        population <- map[Constants.forecastEntity.city.population]
        timezone <- map[Constants.forecastEntity.city.timezone]
    }
    
}

class Coord: Mappable {
    
    var lat : Double?
    var lon : Double?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        lat <- map[Constants.forecastEntity.city.coord.lat]
        lon <- map[Constants.forecastEntity.city.coord.lon]
    }
}

extension Constants {
    public struct forecastEntity {
        public static let cod = "cod"
        public static let message = "message"
        public static let cnt = "cnt"
        public struct list { // []
            public static let list = "list"
            public static let dt = "dt"
            public struct main {
                public static let main = "main"
                public static let temp = "temp"
                public static let temp_min = "temp_min"
                public static let temp_max = "temp_max"
                public static let pressure = "pressure"
                public static let sea_level = "sea_level"
                public static let grnd_level = "grnd_level"
                public static let humidity = "humidity"
                public static let temp_kf = "temp_kf"
            }
            public struct weather { // []
                public static let weather = "weather"
                public static let id = "id"
                public static let main = "main"
                public static let description = "description"
                public static let icon = "icon"
            }
            public struct clouds { // {}
                public static let clouds = "clouds"
                public static let all = "all"
            }
            public struct wind { // {}
                public static let wind = "wind"
                public static let speed = "speed"
                public static let deg = "deg"
            }
            public struct rain { // {}
                public static let rain = "rain"
                public static let treeH = "3h"
            }
            public struct sys { // {}
                public static let sys = "sys"
                public static let pod = "pod"
            }
            public static let dt_txt = "dt_txt"
        }
        public struct city { // {}
            public static let city = "city"
            public static let id = "id"
            public static let name = "name"
            public struct coord { // {}
                public static let coord = "coord"
                public static let lat = "lat"
                public static let lon = "lon"
            }
            public static let country = "country"
            public static let population = "population"
            public static let timezone = "timezone"
        }
    }
}
