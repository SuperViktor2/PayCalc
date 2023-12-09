//
//  Job+CoreDataProperties.swift
//  PayCalc
//
//  Created by Viktor Goleš on 29.07.2023..
//
//

import Foundation
import CoreData


extension Job {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var rate: Double
    @NSManaged public var startDate: Date?
    @NSManaged public var shifts: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var wrappedDate: Date {
        startDate ?? Date()
    }
    
    public var shiftArray: [Shift] {
        let set = shifts as? Set<Shift> ?? []
        
        return set.sorted {
            $0.earned < $1.earned
        }
    }

}

// MARK: Generated accessors for shifts
extension Job {

    @objc(addShiftsObject:)
    @NSManaged public func addToShifts(_ value: Shift)

    @objc(removeShiftsObject:)
    @NSManaged public func removeFromShifts(_ value: Shift)

    @objc(addShifts:)
    @NSManaged public func addToShifts(_ values: NSSet)

    @objc(removeShifts:)
    @NSManaged public func removeFromShifts(_ values: NSSet)

}

extension Job : Identifiable {

}
