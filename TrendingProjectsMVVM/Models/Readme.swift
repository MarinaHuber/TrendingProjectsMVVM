//
//  Content.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/19/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import Foundation

struct Readme: Codable {
    let name, path, sha: String
    let size: Int
    var url, htmlURL: URL?
    var gitURL: URL?
    var downloadURL: URL?
    var type, content: String?

    enum CodingKeys: String, CodingKey {
        case name, path, sha, size, url
        case htmlURL = "html_url"
        case gitURL = "git_url"
        case downloadURL = "download_url"
        case type, content
    }
}
