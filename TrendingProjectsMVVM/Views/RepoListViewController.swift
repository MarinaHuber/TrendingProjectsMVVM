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

    var dataViewModel = DataViewModel()
    var repos: [Repository]   = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableUIAnimate()
    }
        
        func initViewModel(){
            dataViewModel.reloadTableView = {
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
            dataViewModel.showError = {
                DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
            }
            dataViewModel.getData()
            tableView.rowHeight = UITableView.automaticDimension
        }
    
    private func reloadTableUIAnimate() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.tableView.reloadData()
            let visibleInexPaths = self.tableView.indexPathsForVisibleRows
            
            _ = visibleInexPaths.map {
                
                $0.map {
                    let cell = self.tableView.cellForRow(at: $0)
                    cell?.animateStart(0.9, delay: Double($0.row) * 0.02, completion: {
                        completed in
                    })
                }
            }
        })
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

