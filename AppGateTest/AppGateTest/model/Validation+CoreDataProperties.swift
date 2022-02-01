//
//  Validation+CoreDataProperties.swift
//  AppGateTest
//
//  Created by Enar GoMez on 30/01/22.
//
//

import Foundation
import CoreData


extension Validation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Validation> {
        return NSFetchRequest<Validation>(entityName: "Validation")
    }

    @NSManaged public var val_date: Date?
    @NSManaged public var val_json: String?
    @NSManaged public var val_latitude: Double
    @NSManaged public var val_longitude: Double
    @NSManaged public var val_status: Bool
    @NSManaged public var user: User?

}

extension Validation : Identifiable {

}
