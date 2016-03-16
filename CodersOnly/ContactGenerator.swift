//
//  ContactGenerator.swift
//  CodersOnly
//
//  Created by Patrick Zearfoss on 3/16/16.
//  Copyright © 2016 PatZearfoss. All rights reserved.
//

import CoreData

class ContactGenerator {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func generate() {
        
        if let contactDescription = NSEntityDescription.entityForName("Contact", inManagedObjectContext: context) {
            
            let contact1 = Contact(entity: contactDescription, insertIntoManagedObjectContext:context)
            contact1.firstName = "Tim"
            contact1.lastName = "Cook"
            contact1.jobTitle = "CEO"
            contact1.company = "Apple"
            contact1.isFavorite = true
            
            if let addressDescription = NSEntityDescription.entityForName("Address", inManagedObjectContext: context) {
                let address = Address(entity: addressDescription, insertIntoManagedObjectContext: context)
                address.street = "1 Infinite Loop"
                address.city = "Cupertino"
                address.state = "CA"
                address.zip  = "95015"
                address.contact = contact1
            }
            
            if let emailDescription = NSEntityDescription.entityForName("EmailAddress", inManagedObjectContext: context) {
                let email = EmailAddress(entity: emailDescription, insertIntoManagedObjectContext: context)
                email.type = "work"
                email.emailAddress = "tim@apple.com"
                email.contact = contact1
                
                let email2 = EmailAddress(entity: emailDescription, insertIntoManagedObjectContext: context)
                email2.type = "home"
                email2.emailAddress = "infiniteTim@mac.com"
                email2.contact = contact1
            }
            
            let contact2 = Contact(entity: contactDescription, insertIntoManagedObjectContext:context)
            contact2.firstName = "Bill"
            contact2.lastName = "Gates"
            contact2.jobTitle = "President"
            contact2.company = "Microsoft"
            contact2.isFavorite = true
            
            if let emailDescription = NSEntityDescription.entityForName("EmailAddress", inManagedObjectContext: context) {
                let email = EmailAddress(entity: emailDescription, insertIntoManagedObjectContext: context)
                email.type = "work"
                email.emailAddress = "bill@microsoft.com"
                email.contact = contact2
                
                let email2 = EmailAddress(entity: emailDescription, insertIntoManagedObjectContext: context)
                email2.type = "home"
                email2.emailAddress = "bill@hotmail.com"
                email2.contact = contact2
            }
            
            if let phoneDecription = NSEntityDescription.entityForName("PhoneNumber", inManagedObjectContext: context) {
                let phone = PhoneNumber(entity: phoneDecription, insertIntoManagedObjectContext: context)
                phone.type = "work"
                phone.phoneNumber = "703-555-3333"
                phone.contact = contact2
            }

            let contact3 = Contact(entity: contactDescription, insertIntoManagedObjectContext:context)
            contact3.firstName = "Larry"
            contact3.lastName = "Page"
            contact3.jobTitle = "CEO"
            contact3.company = "Google"
            contact3.isFavorite = true
            
            if let emailDescription = NSEntityDescription.entityForName("EmailAddress", inManagedObjectContext: context) {
                let email = EmailAddress(entity: emailDescription, insertIntoManagedObjectContext: context)
                email.type = "work"
                email.emailAddress = "larry@google.com"
                email.contact = contact3
            }
            
            if let socialDescription = NSEntityDescription.entityForName("SocialNetwork", inManagedObjectContext: context) {
                let social = SocialNetwork(entity: socialDescription, insertIntoManagedObjectContext: context)
                social.type = "Google Plus"
                social.handle = "larry@google.com"
                social.contact = contact3
            }
            
            if let phoneDecription = NSEntityDescription.entityForName("PhoneNumber", inManagedObjectContext: context) {
                let phone = PhoneNumber(entity: phoneDecription, insertIntoManagedObjectContext: context)
                phone.type = "work"
                phone.phoneNumber = "703-555-9999"
                phone.contact = contact3
            }
            
        }

        do {
            try context.save()
        } catch {
            print("Couldn't make contacts")
        }
        
    }
}
