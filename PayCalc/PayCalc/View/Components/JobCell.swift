//
//  JobCell.swift
//  PayCalc
//
//  Created by Viktor Goleš on 28.07.2023..
//

import SwiftUI

struct JobCell: View {
    
    let name: String
    let rate: Double
    let startDate: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.title2)
                    .bold()
                Text(rate, format: .currency(code: "EUR"))
            }
            
            Spacer()
            
            Text(startDate.formatted(date: .abbreviated, time: .omitted))
                .foregroundColor(.secondary)
        }
        .padding([.top])
    }
}

struct JobCell_Previews: PreviewProvider {
    static var previews: some View {
        JobCell(name: "Test", rate: 4.50, startDate: Date())
    }
}
