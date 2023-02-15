//
//  SchoolAPI.swift
//  NYCSchoolsCombine
//
//  Created by Julio Reyes on 1/26/23.
//

import Foundation
import Combine

protocol SchoolAPIClientProtocol {
    func fetchSchools() -> AnyPublisher<[School], Error>
}


class SchoolAPI:SchoolAPIClientProtocol {
    
    let baseURLString: String = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    let urlSession = URLSession.shared

    func fetchSchools() -> AnyPublisher<[School], Error> {
        guard let url = URL(string: baseURLString) else {
            fatalError("Invalid URL")
        }
        
        // Return a publisher that fetches schools from an API or a local source
        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [School].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
