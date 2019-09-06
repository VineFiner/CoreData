//
//  NetworkingApi.swift
//  GitHub
//
//  Created by vine on 2019/8/31.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation


protocol NetworkingService {
    @discardableResult func searchRepos(withQuery query: String, completion: @escaping ([Repository]) -> ()) -> URLSessionDataTask
}

final class NetworkingApi: NetworkingService {
    private let session = URLSession.shared

    @discardableResult
    func searchRepos(withQuery query: String, completion: @escaping ([Repository]) -> ()) -> URLSessionDataTask {
        let request = URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=\(query)")!)
        print("url: \(request.url?.absoluteString ?? "\n")\n")
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                    let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                        completion([])
                        return
                }
                completion(response.items)
            }
        }
        task.resume()
        return task
    }
}

fileprivate struct SearchResponse: Decodable {
    let items: [Repository]
}
