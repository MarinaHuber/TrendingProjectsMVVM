//
//  APIService.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/18/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

class APIService {
    
    static let shared   = APIService()
    private let baseURL = "https://ghapi.huchen.dev/"
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getTrendingReposToday(completed: @escaping (Result<[Repository], APIServiceError>) -> Void) {
        let endpoint = baseURL + "repositories?since=daily"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.responseError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.responseError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completed(.failure(.responseError))
                return
            }
            
            do {
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let repo                        = try decoder.decode([Repository].self, from: data)
                completed(.success(repo))
            } catch {
                completed(.failure(.parseError(error)))
            }
        }
        
        task.resume()
    }
    
    
    func getTrendingRepoReadMe(author: String, repoName: String, completed: @escaping (Result<Readme, APIServiceError>) -> Void) {
        
        let url = "https://api.github.com/repos/"
        let endpoint = url + "\(author)/" + "\(repoName)/" + "readme"
        
        guard let urlString = URL(string: endpoint) else {
            completed(.failure(.responseError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString) { data, response, error in
            
            if let _ = error {
                completed(.failure(.responseError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completed(.failure(.responseError))
                return
            }
            
            do {
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let readme                        = try decoder.decode(Readme.self, from: data)
                completed(.success(readme))
            } catch {
                completed(.failure(.parseError(error)))
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
