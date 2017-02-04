//
//  DataManager.swift
//  ALCommon
//
//  Created by andrew lattis on 2/4/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    static let sharedManager = DataManager()

    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    private let persistentContainer: NSPersistentContainer

    private init() {
        //this really only exists for testing purposes, so the data created here is never actually saved to disk
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

}
