//
//  Committee+CoreDataProperties.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/11/02.
//
//

import Foundation
import CoreData


extension Committee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Committee> {
        return NSFetchRequest<Committee>(entityName: "Committee")
    }

    @NSManaged public var isSelected: Bool
    @NSManaged public var name: String?

}

extension Committee: Identifiable {

}
