//
//  SchoolListViewModel.swift
//  NYCSchoolsCombine
//
//  Created by Julio Reyes on 1/26/23.
//

import Foundation
import Combine

class SchoolListViewModel: ObservableObject {
    @Published var schools: [School] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchSchools() {
        let publisher = SchoolAPI().fetchSchools()
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching schools: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { schools in
                print(schools)
                self.schools = schools
            })
            .store(in: &cancellables)
    }
}

struct School: Codable, Identifiable {
    let id: Int
    
    let name: String
    let schoolname: String
    let grade: String
    let street: String
    let building: String
    let zipcode: String
    let phone: String
    let longitude: String
    let latitude: String
}


