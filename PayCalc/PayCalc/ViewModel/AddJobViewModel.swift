//
//  AddJobViewModel.swift
//  PayCalc
//
//  Created by Viktor Goleš on 27.07.2023..
//

import Foundation

final class AddJobViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var rate = ""
    @Published var startDate = Date()
    
    func isInvalidForm() -> Bool {
        name.isEmpty || rate.isEmpty
    }
    
    func limit(_ upper: Int) {
            if rate.count > upper {
                rate = String(rate.prefix(upper))
            }
        }
    
    func saveJob() {
        let job = Job(context: PersistenceController.shared.viewContext)
        
        job.id = UUID().uuidString
        job.name = name
        job.rate = Double(rate.doubleValue)
        job.startDate = startDate
        
        PersistenceController.shared.save()
    }
}
