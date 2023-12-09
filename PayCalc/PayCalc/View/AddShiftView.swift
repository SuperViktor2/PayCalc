//
//  AddShiftView.swift
//  PayCalc
//
//  Created by Viktor Goleš on 08.12.2023..
//

import SwiftUI

struct AddShiftView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddShiftViewModel()
    
    @State private var showDetails = false
    
    var job: Job
    var shift: Shift?
    
    @ViewBuilder
    private func confirmButton () -> some View {
        Button {
            viewModel.saveShift()
            dismiss()
            
        } label: {
            Text("Save")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .disabled(viewModel.isInvalidForm())
    }
    
    
    var body: some View {
        Form {
            TextField("Enter number of regular hours worked", text: $viewModel.normalRate)
                .keyboardType(.numberPad)
            
            Picker("Decimal", selection: $viewModel.norDec) {
                Text("0.25").tag(0.25)
                Text("0.50").tag(0.50)
                Text("0.75").tag(0.75)
            }
            .pickerStyle(.segmented)
            
            TextField("Enter number of night hours worked", text: $viewModel.nightRate)
                .keyboardType(.numberPad)
            
            Picker("Appearance", selection: $viewModel.nirDec) {
                Text("0.25").tag(0.25)
                Text("0.50").tag(0.50)
                Text("0.75").tag(0.75)
            }
            .pickerStyle(.segmented)
            
            DatePicker("Date", selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
            
            Button("Help") {
                            showDetails.toggle()
                        }
                        .frame(maxWidth: .infinity)

            if showDetails {
                VStack {
                    Text("Decimal picker: represents minutes")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("0.25 = 15 min")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("0.50 = 30 min")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("0.75 = 45 min")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .navigationTitle(shift != nil ? "Edit shift" : "Add shift")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                confirmButton()
            }
        }
        .onAppear {
            viewModel.setJobObject(job: job)
            viewModel.setShiftObject(shift: shift)
            viewModel.setupEditView()
        }
    }
}
