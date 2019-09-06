//
//  Tweet.swift
//  Smashtag
//
//  Created by vine on 2019/9/1.
//  Copyright © 2019 vine. All rights reserved.
//

import UIKit
import CoreData
import GitHub

class Tweet: NSManagedObject {
    class func findOrCreateTweet(matching twitterInfo: Repository, in context: NSManagedObjectContext) throws -> Tweet {
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.identifier)

        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                // inconsistency 前后矛盾
                assert(matches.count == 1, "Tweet.findOrCreateTweet -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }

        let tweet = Tweet(context: context)
        tweet.unique = twitterInfo.identifier
        tweet.text = twitterInfo.name
        tweet.created = twitterInfo.created
        tweet.tweeter = try? TwitterUser.findOrCreateTwitterUser(matching: twitterInfo.owner, in: context)
        return tweet
    }
}
