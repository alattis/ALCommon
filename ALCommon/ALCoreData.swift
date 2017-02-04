//
//  ALCoreData.swift
//  ALCommon
//
//  Created by andrew lattis on 2/2/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import Foundation
import CoreData

extension NSFetchedResultsController {

    /// Number of sections available, or 0
    ///
    /// - Returns: Always returns an integer, if no sections are available 0 is returned
    internal func safeSections() -> Int {
        guard let sections = self.sections else { return 0 }

        return sections.count
    }

    /// Number of items in a section, or 0
    ///
    /// - Parameter section: The section to check for items
    /// - Returns: Always returns an integer, if no items are available 0 is returned
    internal func safeNumberOfItems (inSection section: Int) -> Int {
        guard let sections = self.sections, section < sections.count else { return 0 }

        let currentSection = sections[section]
        return currentSection.numberOfObjects
    }

    /// Returns the object at a given index, or nil
    ///
    /// - Parameter indexPath: Path of the object to return
    /// - Returns: Always returns an object, if no items are available nil is returned
    internal func safeObject(atIndexPath indexPath: IndexPath) -> AnyObject? {
        guard (indexPath as NSIndexPath).item < self.safeNumberOfItems(inSection: (indexPath as NSIndexPath).section) else { return nil }

        return self.object(at: indexPath)
    }
}

extension NSManagedObject {
    /// Execute a fetch to find a single object matching by the primary id
    ///
    /// - Parameter id: Primary id of the object to return
    /// - Parameter context: Context to execute the query in
    /// - Returns: The object that matches the search, if any.
    internal static func fetchObject(withId id: Int, inContext context: NSManagedObjectContext) -> AnyObject? {
        let predicate = NSPredicate.init(format: "id == %d", id)

        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest.init()
        fetchRequest.entity = self.entity()
        fetchRequest.predicate = predicate

        fetchRequest.fetchLimit = 1

        var results: Array<AnyObject> = []
        do {
            try results = context.fetch(fetchRequest)
        } catch {
            return nil
        }

        return results.first
    }

    /// Returns the updated at timestamp of the newest object. This function is synchronous and could lock the calling thread on extremely large data sets.
    ///
    /// - Parameter context: Context to execute the query in
    /// - Returns: Unix timestamp of the newest object, or 0 if the Entity is empty
    internal static func timestampOfNewestObject(inContext context: NSManagedObjectContext) -> Int {
        let updatedFetch = fetchRequest()
        updatedFetch.entity = entity()
        updatedFetch.fetchLimit = 1
        updatedFetch.resultType = .dictionaryResultType

        let sortDescriptor = NSSortDescriptor.init(key: "updatedAt", ascending: false)

        updatedFetch.sortDescriptors = [sortDescriptor]

        var results: [Any] = []
        context.performAndWait {
            try? results = context.fetch(updatedFetch)
        }

        var timestamp: Int = 0
        if let result = results.first as? Dictionary<String, Any>, let modelTimestamp = result["updatedAt"] as? NSNumber {
            timestamp = modelTimestamp.intValue
        }

        return timestamp
    }

}

extension NSFetchRequest {
    /// Create a new fetch request with a supplied entity and predicate
    ///
    /// Parameter entity: Entity description of the object to fetch
    /// Parameter predicate: Predicate used to limit the query
    /// Return: A new fetch request instance
    convenience init?(entity: NSEntityDescription, predicate: NSPredicate) {
        self.init()
        self.entity = entity
        self.predicate = predicate
    }
}
