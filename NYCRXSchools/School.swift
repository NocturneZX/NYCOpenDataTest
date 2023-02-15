//
//  School.swift
//  NYCRXSchools
//
//  Created by Julio Reyes on 2/14/23.
//

import Foundation

struct School: Codable, Identifiable {
    var id = UUID()
    
    let dbn: String?
    let schoolName: String?
    let schoolAddress: String?
    let schoolCity: String?
    let schoolStateCode: String?
    let zipcode: String?
    let phoneNumber: String?
    
    let startTime: String?
    let endTime: String?
    let grade: String?
    let buildingCode: String?

    let longitude: String?
    let latitude: String?
    let overviewParagraph: String?
    let schoolInterests: String?
    let schoolPrograms: String?
    let website: String?
    let schoolEmail: String?
    let totalStudents: String?
    let attendanceRate: String?
    
    var SATS: SchoolSAT?
    
    private enum CodingKeys: String, CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
        case schoolAddress = "primary_address_line_1"
        case schoolCity = "city"
        case schoolStateCode = "state_code"
        case zipcode = "zip"
        case phoneNumber = "phone_number"
        
        case startTime = "start_time"
        case endTime = "end_time"
        case grade = "finalgrades"
        case buildingCode = "building_code"
        case longitude = "longitude"
        case latitude = "latitude"
        
        case overviewParagraph = "overview_paragraph"
        case schoolPrograms = "program1"
        case schoolInterests = "interest1"
        case website = "website"
        case schoolEmail = "school_email"
        case totalStudents = "total_students"
        case attendanceRate = "attendance_rate"
    }
}
