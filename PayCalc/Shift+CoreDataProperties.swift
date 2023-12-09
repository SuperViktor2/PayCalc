//
//  Shift+CoreDataProperties.swift
//  PayCalc
//
//  Created by Viktor Goleš on 29.07.2023..
//
//

import Foundation
import CoreData


extension Shift {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shift> {
        return NSFetchRequest<Shift>(entityName: "Shift")
    }

    @NSManaged public var earned: Double
    @NSManaged public var nightRate: Double
    @NSManaged public var id: String?
    @NSManaged public var normalRate: Double
    @NSManaged public var date: Date?
    @NSManaged public var job: Job?

}

extension Shift : Identifiable {

}
