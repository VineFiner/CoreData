//
//  CourseEntity.swift
//  MultitableCoreData
//
//  Created by vine on 2019/10/5.
//  Copyright © 2019 vine. All rights reserved.
//
import CoreData
import UIKit

class CourseEntity: NSManagedObject {
    static func findOrCreateCourse(matching info: [String: Any], in context: NSManagedObjectContext) throws -> CourseEntity {
        let request: NSFetchRequest<CourseEntity> = CourseEntity.fetchRequest()
        request.predicate = NSPredicate(format: "handle = %@", "1")
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "TwitterUser.findOrCreateTwitterUser -- database inconsistency!")
                return matches[0]
            }
        } catch {
            throw error
        }
        let course = CourseEntity(context: context)
        course.isFollow = true
        return course
    }
}
