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
    var repos: [Repository]   = []
    
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
            tableView.rowHeight = UITableView.automaticDimension
        }
    }

    extension RepoListViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataViewModel.numberOfCells
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell    = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell else {
                fatalError("Cell not exists in storyboard")
            }
            let cellVM               = dataViewModel.getCellViewModel( at: indexPath )
            cell.lblName.text        = cellVM.titleText
            cell.lblDescription.text = cellVM.subTitleText
            cell.lblStars.text       = "\(cellVM.starCount)"
            
            return cell
        }
    }

extension RepoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRepo = dataViewModel.didSelect(at: indexPath.row)
        let storyboard = UIStoryboard(name: "RepoDetail", bundle: nil)
        let detail: DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detail.model = selectedRepo
        navigationController?.pushViewController(detail, animated: true)
    }
}

