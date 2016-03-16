//
//  CodersOnlyTests.swift
//  CodersOnlyTests
//
//  Created by Patrick Zearfoss on 3/16/16.
//  Copyright © 2016 PatZearfoss. All rights reserved.
//

import XCTest
import MagicalRecord

@testable import CodersOnly

class CodersOnlyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        MagicalRecord.setupCoreDataStackWithInMemoryStore()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        MagicalRecord.cleanUp()
    }
    
    func testDisplayedEmailAddress() {
        
        let context = NSManagedObjectContext.MR_defaultContext()
        
        let contact1 = Contact.MR_createEntityInContext(context)!
        contact1.firstName = "Tim"
        contact1.lastName = "Cook"
        contact1.jobTitle = "CEO"
        contact1.company = "Apple"
        contact1.isFavorite = true
        
        if let email = EmailAddress.MR_createEntityInContext(context) {
            email.type = "work"
            email.emailAddress = "tim@apple.com"
            email.contact = contact1
        }
        
        
        context.MR_saveOnlySelfAndWait()
        
        XCTAssert(contact1.displayedEmailAddress == "tim@apple.com", "displayed email should have been tim@apple.com")
        
    }
    
    
}
