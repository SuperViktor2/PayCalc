//
//  AddJobView.swift
//  PayCalc
//
//  Created by Viktor Goleš on 27.07.2023..
//

import SwiftUI
import Combine

struct AddJobView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddJobViewModel()
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button {
            viewModel.saveJob()
            dismiss()
        } label: {
            Text("Save")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .padding()
        .disabled(viewModel.isInvalidForm())
    }
    
    @ViewBuilder
    private func cancelButton() -> some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .padding()
    }

    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Job name", text: $viewModel.name)
                
                TextField("Hourly Rate", text: $viewModel.rate)
                    .keyboardType(.decimalPad)
                    .onReceive(Just(viewModel.rate)) { _ in viewModel.limit(5) }
                
                DatePicker("Started working on", selection: $viewModel.startDate, in: ...Date() , displayedComponents: .date)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton()
                }
            }
        }
    }
}

struct AddJobView_Previews: PreviewProvider {
    static var previews: some View {
        AddJobView()
    }
}
