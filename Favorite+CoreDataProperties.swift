//
//  Favorite+CoreDataProperties.swift
//  Gaongil
//
//  Created by ParkJunHyuk on 2022/11/09.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }
    
    @NSManaged public var lawTitle: String?
    @NSManaged public var institute: String?
    @NSManaged public var progress: String?
    @NSManaged public var proposer: String?
    @NSManaged public var suggestionDate: String?
    @NSManaged public var contentText: String?

}

extension Favorite : Identifiable {

}
