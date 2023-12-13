//
//  ContentView.swift
//  PayCalc
//
//  Created by Viktor Goleš on 27.07.2023..
//

import SwiftUI
import CoreData

struct AllJobsVeiw: View {
    
    @State var isAddJobShowing: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Job.startDate, ascending: true)],
                  animation: .default
    )
    
    private var jobs: FetchedResults<Job>
    
    @ViewBuilder
    private func addButton() -> some View {
        Button {
            isAddJobShowing = true
        } label: {
            Image(systemName: "plus.circle")
                .font(.title3)
        }
        .padding([.vertical, .leading], 5)
    }
    
    var body: some View {
        NavigationStack{
            if(jobs.isEmpty) {
                Text("No jobs")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                    .opacity(90.00)
                    .padding([.top], 40)
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                    .opacity(10.00)
                    
            }
            List {
                ForEach (jobs) { job in
                    NavigationLink(value: Destination.shift(job)){
                        JobCell(name: job.wrappedName, rate: job.rate, startDate: job.wrappedDate)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("My jobs")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    addButton()
                }
            }
            .padding([.top])
            .sheet(isPresented: $isAddJobShowing) {
                AddJobView()
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .shift(let job):
                    ShiftsView(job: job)
                case .addShift(let job, let shift):
                    AddShiftView(job: job, shift: shift)
                }
            }
        }
    }
    
    func deleteItems(offset: IndexSet) {
        withAnimation {
            offset.map{jobs[$0]}.forEach(viewContext.delete)
            PersistenceController.shared.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllJobsVeiw()
    }
}

