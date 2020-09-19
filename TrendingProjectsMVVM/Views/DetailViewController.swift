//
//  DetailViewController.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/20/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var author: String!
    var repository: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.shared.getTrendingRepoReadMe(author: "octokit", repoName: "octokit.rb" ) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let readme):
                    print("content: \(String(describing: readme.content?.base64Decoded()?.htmlAttributedString()))")
                case .failure(let error):
                    print(error)
            }
        }
    }
}
