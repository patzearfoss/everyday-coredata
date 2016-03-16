//
//  EditViewController.swift
//  CodersOnly
//
//  Created by Patrick Zearfoss on 3/16/16.
//  Copyright © 2016 PatZearfoss. All rights reserved.
//

import UIKit
import CoreData
import MagicalRecord

class EditViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var contacts = [Contact]()
    var context = NSManagedObjectContext.MR_defaultContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        
        if let fetchedContacts = Contact.MR_findAllSortedBy("lastName", ascending: true, inContext: context) as? [Contact] {
            
            contacts = fetchedContacts
        }
            
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail" {
            if let dest = segue.destinationViewController as? DetailViewController {
                
                if let indexPath = tableView.indexPathForSelectedRow {
                    tableView.deselectRowAtIndexPath(indexPath, animated: true)
                    let contact = contacts[indexPath.row]
                    
                    dest.contact = contact
                }
                
                
            }
        }
    }
}

extension EditViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = nil
        cell.detailTextLabel?.text = nil
        
        
        // assign the first email address in the sorted list
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = "\(contact.firstName!) \(contact.lastName!)"
        
        if let email = contact.displayedEmailAddress {
            cell.detailTextLabel?.text = email
        }
        
    }
}

extension EditViewController: UITableViewDelegate {
    
}

