//
//  APICaller.swift
//  APIKit
//
//  Created by ios on 2022/04/04.
//

import Foundation

public protocol FetchServiceType {
    func fetchCourNames(completion: @escaping ([String]) -> Void)
}

public class FetchService: FetchServiceType {
    
    public init() {}
    
    public func fetchCourNames(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data) as? [[String: String]] else {
                    completion([])
                    return
                }
                let names = json.compactMap({ $0["name"] })
                completion(names)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
}
