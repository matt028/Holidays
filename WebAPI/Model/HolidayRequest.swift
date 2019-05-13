//
//  HolidayRequest.swift
//  WebAPI
//
//  Created by Matthew Sutton on 5/13/19.
//  Copyright © 2019 Matthew Sutton. All rights reserved.
//

import Foundation

enum HolidayError: Error {
    case noDataAvalible
    case canNotProccessData
}

struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = "Your api key"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _  in
            guard let jsonData = data else {
                completion(.failure(.noDataAvalible))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            } catch {
                completion(.failure(.canNotProccessData))
            }
        }
        
        dataTask.resume()
    }
}
