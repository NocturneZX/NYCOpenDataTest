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


class SchoolAPI: SchoolAPIClientProtocol {
    
    let schoolWithSATScoreURL = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    
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
   
    func fetchSchool(with id: String) -> AnyPublisher<School, Error> {
        guard let url = URL(string: baseURLString + "?dbn=\(id)") else {
            fatalError("Invalid URL")
        }
       
        // Return a publisher that fetches a specific school from the API or a local source
        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [School].self, decoder: JSONDecoder())
            .filter { $0.count == 1 }
            .map { $0[0] }
            .eraseToAnyPublisher()
    }
   
    func searchSchools(with name: String) -> AnyPublisher<[School], Error> {
        guard let url = URL(string: baseURLString + "?$q=\(name)") else {
            fatalError("Invalid URL")
        }
       
        // Return a publisher that searches for schools matching the provided name
        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [School].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchSchoolsSATs() -> AnyPublisher<[SchoolSAT], Error> {
        guard let url = URL(string: schoolWithSATScoreURL) else {
            fatalError("Invalid URL")
        }
       
        // Return a publisher that fetches schools from an API or a local source
        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [SchoolSAT].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
