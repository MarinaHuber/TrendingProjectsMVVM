//
//  ViewController.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/19/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

class RepoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var dataViewModel = DataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        
    }
        
        func initViewModel(){
            dataViewModel.reloadTableView = {
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
            dataViewModel.showError = {
                DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
            }
            dataViewModel.showLoading = {
           //     DispatchQueue.main.async { self.activityIndicator.startAnimating() }
            }
            dataViewModel.hideLoading = {
           //     DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            }
            dataViewModel.getData()
        }
    }

    extension RepoListViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataViewModel.numberOfCells
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell else {
                fatalError("Cell not exists in storyboard")
            }
            let cellVM = dataViewModel.getCellViewModel( at: indexPath )
            cell.lblName.text = cellVM.titleText
           // cell.lblDescription.text = cellVM.subTitleText
            return cell
        }
    }
