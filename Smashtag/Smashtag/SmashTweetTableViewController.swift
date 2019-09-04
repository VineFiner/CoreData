//
//  SmashTweetTableViewController.swift
//  Smashtag
//
//  Created by vine on 2019/9/1.
//  Copyright © 2019 vine. All rights reserved.
//

import UIKit
import GitHub
import CoreData

class SmashTweetTableViewController: TweetTableViewController {

    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    override func insetTweets(_ newTweets: [Repository]) {
        super.insetTweets(newTweets)
        // 这里进行后台存储
        updateDatabase(with: newTweets)
    }

    private func updateDatabase(with tweets: [Repository]) {
        print("starting database load")
        container?.performBackgroundTask({ [weak self] (context) in
            for twitterInfo in tweets {
                // add Tweet
                _ = try? Tweet.findOrCreateTweet(matching: twitterInfo, in: context)
            }
            try? context.save()
            print("done loading database")
            self?.printDatabaseStatistics()
        })
    }
    private func printDatabaseStatistics() {
        if let context = container?.viewContext {
            context.perform {
                if Thread.isMainThread {
                    print("on main thread")
                } else {
                    print("off main thread")
                }
                //            let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
                //            if let tweetCount = (try? context.fetch(request))?.count {
                //                print("\(tweetCount) tweets")
                //            }
                if let tweetCount = (try? context.fetch(Tweet.fetchRequest()))?.count {
                    print("\(tweetCount) tweets")
                }
                if let tweeterCount = try? context.count(for: TwitterUser.fetchRequest()) {
                    print("\(tweeterCount) Twitter users")
                }
            }
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Tweeters Mentioning Search Term" {
            if let tweeterTVC = segue.destination as? SmashTweeterTableViewController {
                tweeterTVC.mention = searchText
                tweeterTVC.container = container
            }
        }
    }


}
