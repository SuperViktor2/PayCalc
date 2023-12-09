//
//  AddShiftViewModel.swift
//  PayCalc
//
//  Created by Viktor Goleš on 22.07.2023..
//

import Foundation

final class AddShiftViewModel: ObservableObject {
    
    @Published var earned: Double = 0
    @Published var norDec: Double = 0
    @Published var nirDec: Double = 0
    @Published var nightRate = ""
    @Published var normalRate = ""
    @Published var date = Date()
    
    private var job: Job?
    private var shift: Shift?
    
    func setJobObject(job: Job) {
        self.job = job
    }
    
    func setShiftObject(shift: Shift?) {
        self.shift = shift
    }
    
    func saveShift() {
        shift != nil ? updateShift() : createNewShift()
    }
    
    func calculateEarnings () {
        let temp1: Double = (Double(normalRate) ?? 0.0) + norDec
        let temp2: Double = (Double(nightRate) ?? 0.0) + nirDec
        earned = (temp1 * (job?.rate ?? 0.0)) + (temp2 * (job?.rate ?? 0.0) * 1.5)
    }
    
    private func createNewShift() {
        let newShift =  Shift(context: PersistenceController.shared.viewContext)
        calculateEarnings()
        
        newShift.id = UUID().uuidString
        newShift.earned = Double(earned)
        newShift.normalRate = (Double(normalRate) ?? 0.0) + norDec
        newShift.nightRate = (Double(nightRate) ?? 0.0) + nirDec
        newShift.date = date
        newShift.job = job
        
        
        PersistenceController.shared.save()
    }
    
    func setupEditView() {
        guard let shift = shift else { return }
        calculateEarnings()
        
        earned = shift.earned
        date = shift.date ?? Date()
        nightRate = "\(shift.nightRate)"
        normalRate = "\(shift.normalRate)"
    }
    
    private func updateShift() {
        guard let shift = shift else { return }
        calculateEarnings()
        
        shift.earned = Double(earned)
        shift.date = date
        shift.nightRate = Double(nightRate) ?? 0.0
        shift.normalRate = Double(normalRate) ?? 0.0
        
        PersistenceController.shared.save()
    }
    
    func isInvalidForm() -> Bool {
        nightRate.isEmpty && normalRate.isEmpty && norDec == 0 && nirDec == 0
    }
}
