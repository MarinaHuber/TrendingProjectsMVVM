//
//  ViewController.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/19/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

class RepoListViewController: UIViewController {
    
    var author: String!
    var repository: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.shared.getTrendingReposToday { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let repo):
                    print(repo)

                case .failure(let error):
                    print(error)
            }
        }
        
    }
    
    
}

