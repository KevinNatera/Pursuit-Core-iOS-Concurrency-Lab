//
//  CityStruct.swift
//  ConcurrencyLabProj
//
//  Created by Kevin Natera on 9/3/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import UIKit


struct Countries : Codable {
    let name: String
    let capital: String
    let population: Int
    let flag: String
    
    static func getCountryData(from data: Data) throws -> [Countries] {
        do {
            let countryData = try JSONDecoder().decode([Countries].self, from: data)
            return countryData
        } catch {
            print(error)
            throw error
        }
    }
}
