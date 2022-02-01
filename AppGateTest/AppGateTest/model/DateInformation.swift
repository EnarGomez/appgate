//
//  DateInformation.swift
//  AppGateTest
//
//  Created by Enar GoMez on 30/01/22.
//

import Foundation

struct DateInformation: Decodable {
    
    let sunrise: String
    let lng: Double
    let countryCode: String
    let gmtOffset: Int
    let rawOffset: Int
    let sunset: String
    let timezoneId: String
    let dstOffset: Int
    let countryName: String
    let time: String
    let lat: Double
}
