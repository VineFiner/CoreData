//
//  Owner.swift
//  GitHub
//
//  Created by vine on 2019/8/31.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation
// 用户
public struct Owner: Decodable {
    public let id: Int
    public let avatar_url: String
    public let login: String
}
