//
//  DetailViewController.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/20/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var starsSegmented: UISegmentedControl!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var readmeLabel: UILabel!
    @IBOutlet var repoDescription: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var model: Repository?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = model?.name
        getDataReadme(author: model?.author ?? "", repo: model?.name ?? "")
        authorLabel.text = model?.author
        repoDescription.text = model?.description
        starsSegmented.setTitle("\(model?.stars ?? 0) Stars", forSegmentAt: 0)
        starsSegmented.setTitle("\(model?.forks ?? 0) Forks", forSegmentAt: 1)
        configureUIElements()
    }
    
    func configureUIElements() {
        downloadAvatarImage()
    }
    
    
    func downloadAvatarImage() {
        activityIndicator.startAnimating()
        APIService.shared.downloadImage(from: model?.avatar ?? "") { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImage.image = image
                self.avatarImage.maskCircle(anyImage: image!)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func getDetails() {
        APIService.shared.getTrendingReposToday { [weak self] result in
            guard let self  = self else { return }
            switch result {
                case .success(let repos):
                 DispatchQueue.main.async {
                    _ = repos.map {
                        self.authorLabel.text = $0.author
                        self.repoDescription.text = $0.description
                    }
                }
                case .failure:
                    self.showAlert("No repository")
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

