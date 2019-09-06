//
//  Request.swift
//  GitHub
//
//  Created by vine on 2019/8/31.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation

public final class Request: NSObject {
    private var currentSearchNetworkTask: URLSessionDataTask?
    private let networkingService: NetworkingService

    private let search: String
    private let count: Int

    init(networkingService: NetworkingService, search: String, count: Int) {
        self.networkingService = networkingService
        self.search = search
        self.count = count
    }

    public convenience init(search: String, count: Int) {
        self.init(networkingService: NetworkingApi(), search: search, count: count)
    }

    public func fetchRepos(_ handler: @escaping ([Repository]) -> Void) {
        currentSearchNetworkTask?.cancel() // cancel previous pending request
        currentSearchNetworkTask = networkingService.searchRepos(withQuery: self.search, completion: { (repos) in
            handler(repos)
        })
    }
}
