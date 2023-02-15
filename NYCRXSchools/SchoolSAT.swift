//
//  SchoolSAT.swift
//  NYCRXSchools
//
//  Created by Julio Reyes on 2/14/23.
//

import Foundation


class SchoolSAT: Codable, Identifiable {
    var dbn: String?
    var SchoolTestTakers: String?
    var SATCriticalReadingAvgScore: String?
    var SATMathAvgScore: String?
    var SATWritinAvgScore: String?
    
    private enum CodingKeys: String, CodingKey {
        case dbn = "dbn"
        case SchoolTestTakers = "num_of_sat_test_takers"
        case SATCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case SATMathAvgScore  = "sat_math_avg_score"
        case SATWritinAvgScore = "sat_writing_avg_score"
    }
}
