//
//  ShiftViewModel.swift
//  PayCalc
//
//  Created by Viktor Goleš on 28.07.2023..
//

import SwiftUI

final class ShiftViewModel: ObservableObject {
    
    @Published private(set) var totalPay: Double = 0.0
    @Published private(set) var totalMonth: Double = 0.0
    @Published private(set) var allShifts: [Shift] = []
    @Published private(set) var allShiftObjects: [ShiftObject] = []
    
    
    private var job: Job?
    
    func SetJobObject (job: Job) {
        self.job = job
        setShifts()
    }
    
    func calculatePay () {
        totalPay = allShifts.reduce(0) {$0 + $1.earned}
    }
    
    
    private func setShifts() {
        guard let job = job else {return}
        
        allShifts = job.shiftArray
    }
    
    func totalInMonth () {
        let dict = Dictionary(grouping: allShifts, by: {$0.date?.intOfMonth})
        
        if(allShifts.isEmpty) {
            totalMonth = 0
        }
        
        for (key, value) in dict {
            guard let key = key else {return}
            
            let monthInt = Calendar.current.component(.month, from: Date())
            
            if(key ==  monthInt) {
                totalMonth = value.reduce(0) { $0 + $1.earned }
            }
        }
    }
    
    func separateByMonth() {
        allShiftObjects = []
        
        let dict = Dictionary(grouping: allShifts, by: {$0.date?.intOfMonth})
        
        for (key, value) in dict {
            guard let key = key else {return}
            
            let total = value.reduce(0) { $0 + $1.earned }
            
            allShiftObjects.append(ShiftObject(sectionName: "\(key)", sectionObjects: value.reversed(), sectionTotal: total))
        }
        allShiftObjects.sort(by: {$0.sectionName > $1.sectionName})
    }
    
    func deleteItem (shiftObject: ShiftObject, index: IndexSet) {
        guard let deleteIndex = index.first else {return}
        
        let shiftToDeleate = shiftObject.sectionObjects[deleteIndex]
        
        PersistenceController.shared.viewContext.delete(shiftToDeleate)
        PersistenceController.shared.save()
        
        setShifts()
        totalInMonth()
        calculatePay()
        separateByMonth()
    }
}
