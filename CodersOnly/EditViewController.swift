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
        tableView.editing = true
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
    
    @IBAction func doneButtonTap(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToList", sender: self)
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            let contact = contacts[indexPath.row]
            contact.MR_deleteEntity()
            context.MR_saveToPersistentStoreWithCompletion { success, error in
                if success {
                    self.contacts.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                }
            }
            
        }
        
    }
}

extension EditViewController: UITableViewDelegate {
    
}

