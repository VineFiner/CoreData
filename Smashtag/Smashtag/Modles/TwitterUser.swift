//
//  TwitterUser.swift
//  Smashtag
//
//  Created by vine on 2019/9/1.
//  Copyright © 2019 vine. All rights reserved.
//

import UIKit
import CoreData
import GitHub

class TwitterUser: NSManagedObject {
    static func findOrCreateTwitterUser(matching twitterInfo: Owner, in context: NSManagedObjectContext) throws -> TwitterUser {
        let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        request.predicate = NSPredicate(format: "handle = %@", twitterInfo.login)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "TwitterUser.findOrCreateTwitterUser -- database inconsistency!")
                return matches[0]
            }
        } catch {
            throw error
        }

        let twitterUser = TwitterUser(context: context)
        twitterUser.handle = twitterInfo.login
        twitterUser.name = twitterInfo.login
        return twitterUser
    }
}
