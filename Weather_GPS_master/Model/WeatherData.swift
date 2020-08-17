//
//  weartherData.swift
//  Weather_GPS_master
//
//  Created by Mac on 16/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import Foundation

// EXTRACTING OUR DATA FROM DECODED DATA
struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable{
    let description: String
    let id: Int
}
