//
//  Holiday.swift
//  WebAPI
//
//  Created by Matthew Sutton on 5/13/19.
//  Copyright © 2019 Matthew Sutton. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}
