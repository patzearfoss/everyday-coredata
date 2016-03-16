//
//  DetailViewController.swift
//  CodersOnly
//
//  Created by Patrick Zearfoss on 3/15/16.
//  Copyright © 2016 PatZearfoss. All rights reserved.
//

import UIKit

private struct Pair {
    let label: String
    let value: String?
}

class DetailViewController: UITableViewController {

    var contact: Contact? {
        didSet {
            if let _ = contact {
                buildTableModel()
                tableView.reloadData()
            }
        }
    }
    
    let possibleSectionKeys = ["basic", "emails", "phones", "socials", "addresses"]
    var orderedSectionKeys = [String]()
    
    var tableModel = [String: [String]]()
    
    func buildTableModel() {
        
        if let contact = contact {
            
            var model = [String: [String]]()
            
            let pairs = [Pair(label: "first", value: contact.firstName),
                         Pair(label: "last", value: contact.lastName),
                         Pair(label: "company", value: contact.company),
                         Pair(label: "job title", value: contact.jobTitle)]
            
            let basicInfo = pairs.flatMap{ pair -> String? in
                if let value = pair.value {
                    return "\(pair.label): \(value)"
                }
                return nil
            }
            
            if basicInfo.count > 0 {
                model["basic"] = basicInfo
                orderedSectionKeys.append("basic")
            }
            
            if let emails = contact.emails?.allObjects as? [EmailAddress] where emails.count > 0 {
                let emailInfo = emails.flatMap{ $0.asString() }
                if emailInfo.count > 0 {
                    model["emails"] = emailInfo
                    orderedSectionKeys.append("emails")
                }
            }
            
            if let phones = contact.phones?.allObjects as? [PhoneNumber] where phones.count > 0 {
                let phoneInfo = phones.flatMap{ $0.asString() }
                if phoneInfo.count > 0 {
                    model["phones"] = phoneInfo
                    orderedSectionKeys.append("phones")
                }
            }
            
            if let socials = contact.socialNetworks?.allObjects as? [SocialNetwork] where socials.count > 0 {
                let socialInfo = socials.flatMap{ $0.asString() }
                if socialInfo.count > 0 {
                    model["socials"] = socialInfo
                    orderedSectionKeys.append("socials")
                }
            }

            if let addresses = contact.addresses?.allObjects as? [Address] where addresses.count > 0 {
                let addressInfo = addresses.flatMap{ $0.asString() }
                if addressInfo.count > 0 {
                    model["addresses"] = addressInfo
                    orderedSectionKeys.append("addresses")
                }
            }
            
            tableModel = model
            
        } else {
            tableModel = [String : [String]]()
        }
        
    }
    
}

extension DetailViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = orderedSectionKeys[section]
        let items = tableModel[key]
        return items?.count ?? 0
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableModel.keys.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let key = orderedSectionKeys[indexPath.section]
        if let items = tableModel[key] {

            cell.textLabel?.text = items[indexPath.row]
            
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return orderedSectionKeys[section]
    }
}

private extension EmailAddress {
    func asString() -> String? {
        guard let value = emailAddress else {
            return nil
        }
        
        var string = value
        if let label = type {
            string = "\(label): \(value)"
        }
        
        return string

    }
}

private extension PhoneNumber {
    func asString() -> String? {
        guard let value = phoneNumber else {
            return nil
        }
        
        var string = value
        if let label = type {
            string = "\(label): \(value)"
        }
        
        return string
    }
}

private extension SocialNetwork {
    
    func asString() -> String? {
        guard let value = handle else {
            return nil
        }
        
        var string = value
        if let label = type {
            string = "\(label): \(value)"
        }
        
        return string

    }
}

private extension Address {
    
    func asString() -> String? {
        
        var string = (type != nil) ? "\(type): " : ""
        if let street = street {
            string += street
        }
        
        if let city = city, let state = state {
            string += "\(city), \(state)"
        }
        else if let city = city {
            string += city
        }
        else if let state = state {
            string += state
        }
        
        if let zip = zip {
            string += " \(zip)"
        }
        
        return string.characters.count > 0 ? string : nil
        
    }
    
}

