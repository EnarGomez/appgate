//
//  User+CoreDataProperties.swift
//  AppGateTest
//
//  Created by Enar GoMez on 30/01/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var use_password: String?
    @NSManaged public var use_username: String?
    @NSManaged public var validations: NSSet?
    
    public var validationArray: [Validation] {
        let set = validations as? Set<Validation> ?? []
        return Array(set)
    }

}

// MARK: Generated accessors for validations
extension User {

    @objc(addValidationsObject:)
    @NSManaged public func addToValidations(_ value: Validation)

    @objc(removeValidationsObject:)
    @NSManaged public func removeFromValidations(_ value: Validation)

    @objc(addValidations:)
    @NSManaged public func addToValidations(_ values: NSSet)

    @objc(removeValidations:)
    @NSManaged public func removeFromValidations(_ values: NSSet)

}

extension User : Identifiable {

}
