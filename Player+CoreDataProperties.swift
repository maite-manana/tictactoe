//
//  Player+CoreDataProperties.swift
//  
//
//  Created by Maite Mañana on 6/1/17.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var matches: NSSet?
    @NSManaged public var newRelationship: Match?

}

// MARK: Generated accessors for matches
extension Player {

    @objc(addMatchesObject:)
    @NSManaged public func addToMatches(_ value: Match)

    @objc(removeMatchesObject:)
    @NSManaged public func removeFromMatches(_ value: Match)

    @objc(addMatches:)
    @NSManaged public func addToMatches(_ values: NSSet)

    @objc(removeMatches:)
    @NSManaged public func removeFromMatches(_ values: NSSet)

}
