//
//  Repository.swift
//  GitHub
//
//  Created by vine on 2019/8/31.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation
// 仓库
public struct Repository: Decodable {
    public let id: Int
    public let name: String
    public let created_at: String
    public var created: Date {
        guard let formatDate = Repository.dateFormatter.date(from: created_at) else {
            return Date()
        }
        return formatDate
    }
    public let owner: Owner

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd"
        return formatter
    }()
}
