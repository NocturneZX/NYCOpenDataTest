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
                //print(schools)
                self.schools = schools
                self.fetchSATScores()
            })
            .store(in: &cancellables)
    }
    
    func fetchSATScores() {
        let publisher = SchoolAPI().fetchSchoolsSATs()
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching SAT SCORES: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { scores in
                for score in scores {
                    if let index = self.schools.firstIndex(where: {$0.dbn == score.dbn}){
                        var schoolWithSATScores = School(dbn: self.schools[index].dbn, schoolName: self.schools[index].schoolName, schoolAddress: self.schools[index].schoolAddress, schoolCity: self.schools[index].schoolCity, schoolStateCode: self.schools[index].schoolStateCode, zipcode: self.schools[index].zipcode, phoneNumber: self.schools[index].phoneNumber, startTime: self.schools[index].startTime, endTime: self.schools[index].endTime, grade: self.schools[index].grade, buildingCode: self.schools[index].buildingCode, longitude: self.schools[index].longitude, latitude: self.schools[index].latitude, overviewParagraph: self.schools[index].overviewParagraph, schoolInterests: self.schools[index].schoolInterests, schoolPrograms: self.schools[index].schoolPrograms, website: self.schools[index].website, schoolEmail: self.schools[index].schoolEmail, totalStudents: self.schools[index].totalStudents, attendanceRate: self.schools[index].attendanceRate)
                        schoolWithSATScores.SATS = score
                        self.schools[index] = schoolWithSATScores
                    }
                }
            })
            .store(in: &cancellables)
    }
}
