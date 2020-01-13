//
//  SectionEntity.swift
//  MultitableCoreData
//
//  Created by vine on 2019/10/5.
//  Copyright © 2019 vine. All rights reserved.
//
import CoreData
import UIKit

class SectionEntity: NSManagedObject {
    static func findOrCreateSection(matching info: [String: Any], in context: NSManagedObjectContext) throws -> SectionEntity {
        // 查找实体
        let request: NSFetchRequest<SectionEntity> = SectionEntity.fetchRequest()
        // 创建实体
        let section = SectionEntity(context: context)
        // 课程
        
        return section
    }
}
