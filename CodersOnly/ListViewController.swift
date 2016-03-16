//
//  ViewController.swift
//  CodersOnly
//
//  Created by Patrick Zearfoss on 3/15/16.
//  Copyright © 2016 PatZearfoss. All rights reserved.
//

import UIKit
import CoreData
import MagicalRecord

class ListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var contacts = [Contact]() {
        didSet {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) {
                self.naughtyLog(self.contacts)
            }
        }
    }
    var context: NSManagedObjectContext?

    var fetchedResultsController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let context = context {
            
            fetchedResultsController = Contact.MR_fetchAllSortedBy("lastName", ascending: true, withPredicate: nil, groupBy: nil, delegate: self, inContext: context)

            if let items = fetchedResultsController.fetchedObjects as? [Contact] {
                contacts = items
                tableView.reloadData()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func makeContacts(sender: AnyObject) {
        
        if let context = context {
            let generator = ContactGenerator(context: context)
            generator.generate()
        }
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

extension ListViewController {
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
    }
}

extension ListViewController: UITableViewDataSource {
    
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

extension ListViewController {
    
    func naughtyLog(contacts: [Contact]) {
        
        print ("*** Log all the contacts ***")
        
        contacts.forEach{
            print ($0.firstName! + " " + $0.lastName!)
        }
        
        print ("*** That's all there is ***")
    }
    
}

extension ListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        if let items = controller.fetchedObjects as? [Contact] {
            contacts = items
            tableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDelegate {

}

