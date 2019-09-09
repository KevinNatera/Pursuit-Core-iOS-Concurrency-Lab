//
//  APIClient.swift
//  ConcurrencyLabProj
//
//  Created by Kevin Natera on 9/8/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import Foundation
import UIKit



enum AppError: Error {
    case badJSONError
    case networkError
    case noDataError
    case badHTTPResponse
    case badUrl
    case notFound
    case unauthorized
    case badImageData
    case other(errorDescription: String)
}



class NetworkManager {

private init() {}

static let shared = NetworkManager()

func fetchData(urlString: String,  completionHandler: @escaping (Result<[Countries],AppError>) -> ()) {
    let urlString = "https://restcountries.eu/rest/v2/name/united"
    guard let url = URL(string: urlString) else {
        completionHandler(.failure(.badUrl))
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard error == nil else {
            completionHandler(.failure(.networkError))
            return
        }
        
        guard let data = data else {
            completionHandler(.failure(.noDataError))
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completionHandler(.failure(.badHTTPResponse))
            return
        }
        
        switch response.statusCode {
        case 404:
            completionHandler(.failure(.notFound))
        case 401,403:
            completionHandler(.failure(.unauthorized))
        case 200...299:
            completionHandler(.success(data))
        default:
            completionHandler(.failure(.other(errorDescription: "Wrong Status Code")))
        }
        }.resume()
}

}


