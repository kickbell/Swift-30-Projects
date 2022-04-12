//
//  Service.swift
//  Tap
//
//  Created by jc.kim on 4/12/22.
//

import RxSwift

class Service {
    static func getImage(_ completion: @escaping (Data) -> Void?) {
        let url = URL(string: "https://source.unsplash.com/user/erondu/3000x3000")!
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                return
            }
            completion(data)
        }
        task.resume()
    }
    
    static func request(_ completion: @escaping ([User]) -> Void?) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(users)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    static func requestRx() -> Single<[User]> {
        Single.create { emitter in
            Service.request { users in
                emitter(.success(users))
            }
            return Disposables.create()
        }
    }
    
    static func requestRxImage() -> Single<Data> {
        Single.create { emitter in
            Service.getImage { data in
                emitter(.success(data))
            }
            return Disposables.create()
        }
        .debug("single...")
    }
}

struct User: Decodable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
