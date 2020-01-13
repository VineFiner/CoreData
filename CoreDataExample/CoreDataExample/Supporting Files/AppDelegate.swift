//
//  AppDelegate.swift
//  CoreDataExample
//
//  Created by vine on 2019/8/31.
//  Copyright © 2019 vine. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //在应用程序即将终止时调用。 如果合适，保存数据。 另请参阅applicationDidEnterBackground:。
        //在应用程序终止之前将更改保存在应用程序的托管对象上下文中。

        self.saveContext()
    }

    // MARK: - Core Data stack
    // coredata 堆
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        /*
          应用程序的持久性容器。 这个实现
          创建并返回一个容器，并已为
          应用到它。 该属性是可选的，因为存在合法的
          可能导致存储创建失败的错误条件。
         */
        let modelName = "Model"
        let container = NSPersistentContainer(name: modelName)
        // 容器目录
        let directory = NSPersistentContainer.defaultDirectoryURL()
        let url = directory.appendingPathComponent(modelName + ".sqlite")
        print("pathUrl:\(url)")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */

                //用代码替换此实现，以正确处理错误。
                // fatalError（）使应用程序生成崩溃日志并终止。 尽管此功能在开发过程中可能很有用，但您不应在运输应用程序中使用此功能。
                /*
                  出现错误的典型原因包括：
                  *父目录不存在，无法创建或不允许写入。
                  *由于设备锁定时的权限或数据保护，无法访问持久性存储。
                  *设备空间不足。
                  *无法将商店迁移到当前模型版本。
                  检查错误消息以确定实际的问题是什么。
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //用代码替换此实现，以正确处理错误。
                // fatalError（）使应用程序生成崩溃日志并终止。 尽管此功能在开发过程中可能很有用，但您不应在运输应用程序中使用此功能。
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

