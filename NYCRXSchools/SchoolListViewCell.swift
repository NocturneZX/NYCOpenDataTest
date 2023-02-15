//
//  SchoolListViewCell.swift
//  NYCRXSchools
//
//  Created by Julio Reyes on 2/14/23.
//

import Foundation
import Combine
import UIKit

class SchoolListViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var programsLabel: UILabel!
    @IBOutlet weak var interestsLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    
    private var cancellables = Set<AnyCancellable>()
    private var school: School?
    
    func configure(with school: School) {
        self.school = school
        nameLabel.text = school.schoolName
        locationLabel.text = "\(school.schoolAddress ?? "N/A") , \(school.schoolCity ?? "N/A")), \(school.schoolStateCode ?? "N/A")), \(school.zipcode ?? "N/A"))"
        overviewTextView.text = school.overviewParagraph
        programsLabel.text = "Programs: \(school.schoolPrograms  ?? "N/A")"
        interestsLabel.text = "Interests: \(school.schoolInterests ?? "N/A")"
        phoneButton.setTitle("Call \(school.phoneNumber ?? "N/A")", for: .normal)
    }
    
    @IBAction func callSchool(_ sender: UIButton) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
        school = nil
    }
    
    deinit {
        cancellables.removeAll()
    }
}
