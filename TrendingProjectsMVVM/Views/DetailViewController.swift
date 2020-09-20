//
//  DetailViewController.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/20/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var readmeLabel: UILabel!
    
    var author: String!
    var repository: String!

    var model: Repository?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = model?.name
        getDataReadme(author: model?.author ?? "", repo: model?.name ?? "")
        configureUIElements()
    }
    
    func configureUIElements() {
        downloadAvatarImage()
    }
    
    
    func downloadAvatarImage() {
        APIService.shared.downloadImage(from: model?.avatar ?? "") { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImage.image = image
                self.avatarImage.maskCircle(anyImage: image!)
            }
        }
    }
    
    func getDetails() {
        APIService.shared.getTrendingReposToday { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let repo):
                 DispatchQueue.main.async {
                
                }
                case .failure:
                    self?.showAlert("No repository")
            }
        }
    }
    
    func getDataReadme(author: String, repo: String) {
        APIService.shared.getTrendingRepoReadMe(author: author, repoName: repo ) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let readme):
                    DispatchQueue.main.async { self.readmeLabel.attributedText = readme.content?.base64Decoded()?.htmlAttributedString() }
                case .failure(let error):
                    print(error)
                    self.showAlert("No Readme")
            }
        }
    }
}

