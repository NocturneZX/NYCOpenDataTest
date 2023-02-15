//
//  DetailsViewController.swift
//  NYCRXSchools
//
//  Created by Julio Reyes on 2/14/23.
//

import Foundation
import UIKit
import Combine
import CoreLocation
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate {
    var selectedSchool: School!

    @IBOutlet weak var schoolMapView: MKMapView!
    @IBOutlet weak var schoolAddressLabel: UILabel!
    @IBOutlet weak var schoolPhoneLabel: UILabel!
    @IBOutlet weak var schoolWebsiteLabel: UILabel!
    @IBOutlet weak var schoolSATText: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = "Schools"
        self.title = selectedSchool.schoolName

        self.schoolAddressLabel.text = "ADDRESS: \(selectedSchool.schoolAddress ?? "N/A") , \(selectedSchool.schoolCity ?? "N/A")), \(selectedSchool.schoolStateCode ?? "N/A")), \(selectedSchool.zipcode ?? "N/A"))"
        
        self.schoolPhoneLabel.text = "PHONE NUMBER: \(selectedSchool.phoneNumber ?? "N/A")"
        self.schoolWebsiteLabel.text = "WEBSITE: \(selectedSchool.website ?? "N/A")"
        
        if selectedSchool.SATS?.dbn?.isEmpty == false && selectedSchool.SATS?.SATCriticalReadingAvgScore?.isEmpty == false && selectedSchool.SATS?.SATMathAvgScore?.isEmpty == false && selectedSchool.SATS?.SATWritinAvgScore?.isEmpty == false {
            
            let SATScores: [String] = ["SAT Average Critical Reading Score:  \(selectedSchool.SATS!.SATCriticalReadingAvgScore!)", "SAT Average Math Score: \(selectedSchool.SATS!.SATMathAvgScore!)", "SAT Average Writing Score: \(selectedSchool.SATS!.SATWritinAvgScore!)"]

            let attrString = NSMutableAttributedString(string: "CURRENT SAT SCORES \n\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 24), .foregroundColor: UIColor.black, .paragraphStyle: NSMutableParagraphStyle()])

            for boulletpoint in SATScores {
                let score = NSAttributedString(string: "\(boulletpoint)\n", attributes:  [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.darkGray, .paragraphStyle: NSMutableParagraphStyle()])
                attrString.append(score)
            }


            
            self.schoolSATText.attributedText = attrString
        } else {
            self.schoolSATText.text = "This schools currently does not have SAT Scores posted."
        }
        let lat = Double(selectedSchool.latitude!)!
        let lon = Double(selectedSchool.longitude!)!
        self.addAnnotationWithCoordinates(CLLocationCoordinate2D(latitude: lat, longitude: lon))
        
    }
    
    func addAnnotationWithCoordinates(_ schoolCoordinates: CLLocationCoordinate2D){
        let schoolAnnotation = MKPointAnnotation()
        schoolAnnotation.coordinate = schoolCoordinates
        self.schoolMapView.addAnnotation(schoolAnnotation)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: schoolAnnotation.coordinate, span: span)
        let adjustRegion = self.schoolMapView.regionThatFits(region)
        self.schoolMapView.setRegion(adjustRegion, animated:true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else {
            return nil
        }
        
        let identitfier  = "school pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identitfier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identitfier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
