//
//  ViewController.swift
//  CoreDataExample
//
//  Created by vine on 2019/8/31.
//  Copyright © 2019 vine. All rights reserved.
//
import CoreData
import UIKit

class ViewController: UIViewController {
    /// 持久化容器
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addTweets()
    }

    // 添加一条记录
    func addTweet() {
        if let context = container?.viewContext {

            let tweet = Tweet(context: context)
            // 进行赋值
            tweet.text = ""
            /// 上下文进行保存
            try? context.save()
        }
    }
    // 批量添加
    func addTweets() {
        print("starting database load")
        // 容器异步执行
        container?.performBackgroundTask({[weak self] (context) in
            for index in 0...10 {
                // 创建实体
                let tweet = Tweet(context: context)
                // 进行赋值
                tweet.text = "\(index)"
            }
            // 进行保存
            try? context.save()
            print("done loading database")
            self?.printDatabaseStatistics()
        })
    }
    // 进行删除
    func deleteTweet(identifier: String) {
        // 创建一个查找请求
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        // 配置谓词
        request.predicate = NSPredicate(format: "unique = %@", identifier)

        // 上下文进行查找
        if let context = container?.viewContext {

            guard let matche = try? context.fetch(request).first else {
                  print("没有数据")
                return
            }
            // 进行删除
            context.delete(matche)
            // 进行保存
            try? context.save()
        }
    }
    // 进行查询
    func findTweet(identifier: String) {
        // 创建一个查找请求
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        // 配置谓词, unique 唯一 约束
        request.predicate = NSPredicate(format: "unique = %@", identifier)

        // 上下文进行查找
        if let context = container?.viewContext {
            if let matches = try? context.fetch(request) {
                print("matches:\(matches)")
            }
        }
    }
    // 进行查询
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
}

