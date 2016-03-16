//
//  EmailAddress+CoreDataProperties.swift
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

extension EmailAddress {

    @NSManaged var type: String?
    @NSManaged var emailAddress: String?
    @NSManaged var contact: Contact?

}
