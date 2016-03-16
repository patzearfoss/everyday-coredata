//
//  Contact+CoreDataProperties.swift
//  CodersOnly
//
//  Created by Patrick Zearfoss on 3/15/16.
//  Copyright © 2016 PatZearfoss. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var company: String?
    @NSManaged var jobTitle: String?
    @NSManaged var isFavorite: NSNumber?
    @NSManaged var displayedEmailAddress: String?
    @NSManaged var emails: NSSet?
    @NSManaged var phones: NSSet?
    @NSManaged var socialNetworks: NSSet?
    @NSManaged var addresses: NSSet?

}
