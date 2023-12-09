//
//  PayCalcApp.swift
//  PayCalc
//
//  Created by Viktor Goleš on 27.07.2023..
//

import SwiftUI

@main
struct PayCalcApp: App {

    var body: some Scene {
        WindowGroup {
            AllJobsVeiw()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
