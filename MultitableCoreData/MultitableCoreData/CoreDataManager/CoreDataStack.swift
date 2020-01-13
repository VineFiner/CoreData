//
//  CoreDataStack.swift
//  MultitableCoreData
//
//  Created by vine on 2019/10/5.
//  Copyright © 2019 vine. All rights reserved.
//
import CoreData
import Foundation

class CoreDataStack {
    /// 这里可以用单利来初始化
    static
    let shared = CoreDataStack()

    // 这里是主容器
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
            let container = NSPersistentContainer(name: "CourseList")
            // 这里可以做一些初始化的事情
            self.seedCoreDataContainerIfFirstLaunch()
            // 进行加载数据
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
    // 这里是主上下文
    var viewContext: NSManagedObjectContext {
       return persistentContainer.viewContext
    }
}

// MARK: Internal
extension CoreDataStack {
    // 保存上下文
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: Private
private extension CoreDataStack {

  func seedCoreDataContainerIfFirstLaunch() {

  }

}
