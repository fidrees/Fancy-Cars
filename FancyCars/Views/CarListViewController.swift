//
//  ViewController.swift
//  FancyCars
//
//  Created by Fahad Idrees on 2019-03-10.
//  Copyright © 2019 Fahad Idrees. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private struct Constants {
        static let carListCellIdentifier = "CarListCellIdentifier"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = CarListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleViewModelClosures()
        viewModel.fetchCarList()
    }
    
    //MARK: Private methods
    private func handleViewModelClosures() {
        //Clouse to communicate from viewModel to view controller
        viewModel.updateUIClosure = { [weak self] in
            //Updating UI on main thread
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carListCell =  tableView.dequeueReusableCell(withIdentifier: Constants.carListCellIdentifier, for: indexPath) as! CarListCell
        let cellViewModel = viewModel.cellViewModelAtIndexPath(indexPath: indexPath)
        carListCell.cellViewModel = cellViewModel
        
        return carListCell
    }

    //MARK: IBActions
    @IBAction func sortButtonTapped(button: UIButton) {
        //Show alert to sort data
        let alert = UIAlertController(title: "Sort", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "By Name", style: .default , handler:{ (UIAlertAction)in
            self.viewModel.sortCarsByName()
            self.tableView.reloadData()
            button.titleLabel?.text = "Sort By Name"
        }))
        
        alert.addAction(UIAlertAction(title: "By Availibility", style: .default , handler:{ (UIAlertAction)in
            self.viewModel.sortCardsByAvailibility()
            self.tableView.reloadData()
            button.titleLabel?.text = "Sort By Availibility"
        }))
        
        self.present(alert, animated: true, completion:nil)
    }
    
}

