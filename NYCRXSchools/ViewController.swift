//
//  ViewController.swift
//  NYCRXSchools
//
//  Created by Julio Reyes on 12/15/22.
//

import UIKit
import Foundation
import Combine

class ViewController: UIViewController {
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    
    // View Model
    private let viewModel: SchoolListViewModel = SchoolListViewModel()
    
    // Cancellables
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.bootStrapFetchingSchools()
    }

    private func bootStrapFetchingSchools() {
        viewModel.fetchSchools()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.$schools
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schools.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolListViewCell", for: indexPath) as? SchoolListViewCell
        let school = viewModel.schools[indexPath.row]
        cell?.configure(with: school)
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSchool = viewModel.schools[indexPath.row]
        
        self.performSegue(withIdentifier: "SchoolDetailsViewController", sender: selectedSchool)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass the selected school with sat score to the destinatiion view controller
        if segue.identifier == "SchoolDetailsViewController"{
            let detailsVC = segue.destination as! DetailsViewController
            if let selectedSchool = sender as? School {
                detailsVC.selectedSchool = selectedSchool
            }
        }
    }
}

