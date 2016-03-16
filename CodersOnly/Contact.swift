//
//  Contact.swift
//  CodersOnly
//
//  Created by Patrick Zearfoss on 3/15/16.
//  Copyright © 2016 PatZearfoss. All rights reserved.
//

import Foundation
import CoreData


class Contact: NSManagedObject {

    override func willSave() {
        
        if let emails = emails?.allObjects as? [EmailAddress] where emails.count > 0 {
            
            let topEmail = emails.sort {
                
                if let email0 = $0.emailAddress, let email1 = $1.emailAddress {
                    return email0 < email1
                }
                
                return false
                
                }.first
            
            
            self.displayedEmailAddress = topEmail?.emailAddress
            
        }
    }
}
