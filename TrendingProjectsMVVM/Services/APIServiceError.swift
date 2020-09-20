//
//  APIServiceError.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/18/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    
    case responseError
    case parseError(Error)
}
