//
//  Repository.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/18/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let author: String
    var name: String
    let avatar: String
    var language, languageColor: String?
    var description: String
    let stars: Int
    let forks: Int
    let currentPeriodStars: Int
}
