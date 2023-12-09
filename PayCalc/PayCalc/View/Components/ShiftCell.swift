//
//  ShiftCell.swift
//  PayCalc
//
//  Created by Viktor Goleš on 28.07.2023..
//

import SwiftUI

struct ShiftCell: View {
    
    let normalRate: Double
    let nightRate: Double
    let earned: Double
    let date: Date
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                HStack{
                    Text("\(normalRate, specifier: "%.2f") hours")
                        .font(.title3)
                        .foregroundColor(.blue)
                    Text("R1")
                        .font(.subheadline)
                }
                
                HStack{
                    Text("\(nightRate, specifier: "%.2f") hours")
                        .font(.title3)
                        .foregroundColor(.blue)
                    Text("R2")
                        .font(.subheadline)
                }
            }
            Spacer()
            
            VStack(alignment: .leading, spacing: 5){
                Text("\(date.formatted(date: .numeric, time: .omitted))")
                Text("\(earned, format: .currency(code: "EUR"))")
                    .font(.title)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct ShiftCell_Previews: PreviewProvider {
    static var previews: some View {
        ShiftCell(normalRate: 4.0, nightRate: 4.0, earned: 45.00, date: Date())
    }
}
