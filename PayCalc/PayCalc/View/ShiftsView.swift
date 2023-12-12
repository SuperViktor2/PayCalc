//
//  ShiftsView.swift
//  PayCalc
//
//  Created by Viktor Goleš on 22.07.2023..
//

import SwiftUI

struct ShiftsView: View {
    
    @StateObject private var viewModel = ShiftViewModel()
    
    var job: Job
    @ViewBuilder
    private func addButton() -> some View {
        NavigationLink(value: Destination.addShift(job)) {
            Image (systemName: "plus.circle")
                .font(.title3)
                .padding([.vertical, .leading], 5)
        }
    }
    
    @ViewBuilder
    private func progressVeiew() -> some View {
        VStack{
            HStack {
                Text("Earned this month:")
                Text("\(viewModel.totalMonth, format: .currency(code: "EUR"))")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
            }
            
            Text("Earned in total: \(viewModel.totalPay, format: .currency(code: "EUR"))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 5)
        }
            
    }
    
    var body: some View {
        VStack {
            
            progressVeiew()
            
            //list
            List {
                
                ForEach(viewModel.allShiftObjects, id: \.sectionName) { shiftObject in
                    Section(header: Text("\(shiftObject.sectionName) - \(shiftObject.sectionTotal, format: .currency(code: "EUR"))")) {
                        ForEach (shiftObject.sectionObjects) { shift in
                            NavigationLink(value: Destination.addShift(job, shift)) {
                                ShiftCell(normalRate: shift.normalRate, nightRate: shift.nightRate, earned: shift.earned, date: shift.date ?? Date())
                            }
                        }
                        .onDelete { index in
                            viewModel.deleteItem(shiftObject: shiftObject, index: index)
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
        .navigationTitle(job.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton()
            }
        }
        .onAppear {
            viewModel.SetJobObject(job: job)
            viewModel.separateByMonth()
            viewModel.calculatePay()
            viewModel.totalInMonth()
        }
    }
}
